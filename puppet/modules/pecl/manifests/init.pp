class pecl {

	package { 'build-essential':
	  ensure => installed
	}
	
	package { 'php-pear':
	  ensure => installed,
	  require => Package['php5-cli','php5-fpm','build-essential']
	}

	package { 'php5-dev':
	  ensure => installed,
	  require => Package['php5-cli','php5-fpm','build-essential']
	}	

}