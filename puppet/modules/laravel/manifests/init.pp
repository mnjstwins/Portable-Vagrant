# Class: laravel
#
#
class laravel {

	package { "git-core":
		ensure => installed,
	}

	file { "/var/www/app/index.php":
		ensure => absent,
	}


	file { "laravel config":
		ensure => file,
		path => "/etc/nginx/sites-enabled/laravel",
		source => 'puppet:///modules/laravel/laravel',
		notify => Service['nginx'],
		require => Package['nginx'],
	}


	exec { "remove localhost":
		command => "rm /etc/nginx/sites-enabled/localhost",
		#path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
		#refreshonly => true,
		require => Service['nginx']
	}

	file { 'laravel-enable':
	    path => '/etc/nginx/sites-available/laravel',
	    target => '/etc/nginx/sites-enabled/laravel',
	    ensure => link,
	    notify => Service['nginx'],
	    require => [
	        File['laravel config'],
	    ],
	}
}