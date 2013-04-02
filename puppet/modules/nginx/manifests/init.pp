class nginx
{
    package 
    { 
        'nginx': 
            ensure => installed,
            require => Package['git-core'],
        }

    service 
    { 
        'nginx':
            ensure => running,
            require => Package['nginx'],
    }

    file 
    { 
        'vagrant-nginx':
            path => '/etc/nginx/sites-available/vagrant',
            ensure => file,
            replace => true,
            require => Package['nginx'],
            source => 'puppet:///modules/nginx/vagrant',
            notify => Service['nginx'],
    }


    file 
    { 
        'default-nginx-disable':
            path => '/etc/nginx/sites-enabled/default',
            ensure => absent,
            require => Package['nginx'],
    }

    file 
    { 
        'vagrant-nginx-enable':
            path => '/etc/nginx/sites-enabled/vagrant',
            target => '/etc/nginx/sites-available/vagrant',
            ensure => link,
            notify => Service['nginx'],
            require => [
                File['vagrant-nginx'],
                File['default-nginx-disable'],
            ],
    }
}