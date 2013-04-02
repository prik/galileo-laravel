class laravel 
{

    $root = ["/vagrant/www"]
    $writeable_dirs = ["${root}/app/storage"]

    package 
    { 
        "unzip" : 
            ensure => 'installed',
    }

    file 
    { 
        "${root}":
            ensure  => 'directory'
    }

    exec 
    { 
        'download-laravel':
            cwd     => '/tmp',
            command => '/usr/bin/wget http://github.com/laravel/laravel/archive/develop.zip',
            creates => '/tmp/develop.zip',
            require => Exec['install composer'],
            unless => "[ -d '/vagrant/www/app' ]"
    }


    exec 
    { 
        'unzip-laravel':
            cwd     => '/tmp',
            command => "/usr/bin/unzip develop.zip && /bin/cp -R laravel-develop/* ${root} && /bin/rm -rf develop.zip laravel-develop",
            require => [ File["${root}"], Package['unzip'], Exec['download-laravel'] ],
            unless => "[ -d '/vagrant/www/app' ]"
    }

    file 
    { 
        "${writeable_dirs}":
            ensure  => 'directory',
            recurse => true,
            mode    => '0777',
            require => [ Exec["unzip-laravel"], File["${root}"] ]
    }

    exec 
    { 
        'run-composer-installation':
            command => "/bin/sh -c 'cd /vagrant/www/ && composer install'",
            require => [Exec['unzip-laravel'], Exec['global composer'], Package['git-core']],
            timeout => 900,
    }

}