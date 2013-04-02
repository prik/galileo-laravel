class phpfpm {



	exec { 'updateapt-php': 
	    command => '/usr/bin/apt-get update'
	}

	package { 'php5-fpm':
	  ensure => installed,
	  require => [ Exec['updateapt-php'], Package['nginx'] ]
	}

	package { 'php5-cli':
	  ensure => installed,
	  require => Exec['updateapt-php']
	}

	package { 'php5-mcrypt':
	  ensure => installed,
	  require => Package['php5-fpm']
	}

	package { 'php-apc':
	  ensure => installed,
	  	require => Package['php5-fpm']
	}

	package { 'php5-curl':
	  ensure => installed,
	  require => Package['php5-fpm']
	}

	package { 'php5-xdebug':
	  ensure => installed,
	  require => Package['php5-fpm']
	}

	class { 'pecl': }

	file { "/etc/php5/php.ini": 
	  ensure      => present,
	  source      => "puppet:///modules/phpfpm/php.ini",
	  group       => 'root',
	  mode        => '0644',
	  require => [ Package['php5-fpm'], Package['php5-cli'] ]
	}

	file { "/etc/php5/cli/php.ini":
	  ensure      => link,
	  target      => "/etc/php5/php.ini",
	  require => File['/etc/php5/php.ini']
	}

	file { "/etc/php5/fpm/php.ini": 
	  ensure      => link,
	  target      => "/etc/php5/php.ini",
	  require => File['/etc/php5/php.ini']
	}

	file { "/etc/php5/fpm/pool.d/www.conf": 
	  ensure      => present,
	  source      => "puppet:///modules/phpfpm/www.conf",
	  group       => 'root',
	  mode        => '0644',
	  require => Package['php5-fpm']
	}

	service { 'php5-fpm':
	    ensure => running,
	    subscribe  => File['/etc/php5/fpm/pool.d/www.conf'],
	    require => Package['php5-fpm'],
	}

}