class mysql 
{
    package 
    { 
        "mysql-server":
            ensure  => present,
            require => [ Package['php5-fpm'] ]
    }

    service 
    { 
        "mysql":
            enable => true,
            ensure => running,
            require => Package["mysql-server"],
    }
}
