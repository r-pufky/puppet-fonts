# Install a given font resource.
#
# Args:
#   title: String filename of the font to install.
#   dir: String target font installation directory.
#

define fonts::install($file = $title, $dir) {
  case $::kernel {
    'Linux': {
      file { "${dir}/${file}":
        ensure => 'present',
        path   => "${dir}/${file}",
        source => "puppet:///modules/fonts/${file}",
        notify => Exec["refresh-${file}"],
        mode => '0644',
      } ~>
      exec { "refresh-${file}":
        path => '/bin:/usr/bin',
        command => 'fc-cache -f -v',
      }
    }

    'windows': {
      file { "${dir}/${file}":
        ensure => 'present',
        path   => "${dir}/${file}",
        source => "puppet:///modules/fonts/${file}",
      } ~>
      registry::value { "${file}":
        key => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Fonts',
        data => "${file}",
      } 
    }
    
    default: {
      info('Operating system not supported.')
    }
  }
}
