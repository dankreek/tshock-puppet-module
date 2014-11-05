class tshock::params {
  case $::operatingsystem {
    ubuntu: { $packages = [ "mono-complete", "unzip", "screen" ] }
    default: { fail("Only Ubuntu is currently supported.") }
  }

  $server_url = "https://github.com/NyxStudios/TShock/releases/download/v4.2301/TShock.4.2.3.0720.zip" 

  case $::osfamily {
    debian: {
      $service_loc = '/etc/init/tshock.conf'
      $service_templ = 'tshock.conf.erb'
    }
  }

  $install_loc = $::kernel ? {
    Linux => "/opt/tshock"
  }

  $download_loc = "$install_loc/download"
  $download_dest = "$download_loc/tshock.zip"

  $user = 'tshock'
  $group = 'tshock'
}
