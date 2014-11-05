# == Class: terraria
#
# Full description of class terraria here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'tshock':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Justin May <may.justin@gmail.com> 
#
# === Copyright
#
# Copyright 2014 Justin May.
#
class tshock(
  $packages      = $tshock::params::packages,
  $server_url    = $tshock::params::server_url,
  $download_loc  = $tshock::params::download_loc,
  $download_dest = $tshock::params::download_dest,
  $service_loc   = $tshock::params::service_loc,
  $service_templ = $tshock::params::service_templ,

  $install_loc   = $tshock::params::install_loc,
  $user          = $tshock::params::user,
  $group         = $tshock::params::group,  
  $ip            = "0.0.0.0",
  $port          = 7777,
  $maxplayers    = 8,
  $world         = "default.wld",
  $world_path    = "$tshock::params::install_loc/Terraria/Worlds",
  $world_size    = 1,
  $language      = "English",
  $conn_per_ip   = 8,
) inherits tshock::params {

  group { $group:
    ensure => present,
  }
  ->
  user { $user:
    ensure => present,
    home   => $install_loc,
  }
  ->
  file { [ $install_loc, $download_loc ]:
    ensure => directory,
    owner  => $user,
    group  => $group
  }

  file { "$install_loc/start.sh":
    content => template("tshock/start.sh.erb"),
    mode    => 755,
    require => File[ $install_loc ], 
    notify  => Service[ "tshock" ],
  }

  wget::fetch { $server_url:
    destination => $download_dest,
    require => File[ $download_loc ],
  }
  ->
  package { $packages:
    ensure => installed,
  }
  ->
  exec { "unzip-server":
    cwd     => $install_loc,
    command => "unzip -u \"$download_dest\"",
    path    => [ "/usr/bin" ],
  }

  file { $service_loc:
    content => template("tshock/$service_templ"),
  } 

  service { "tshock":
    ensure  => running,
    enable  => true,
    require => File[ $service_loc ],
  }
}
