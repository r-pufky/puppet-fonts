# Setup given fonts on target systems.
#
# Examples:
#   include fonts
#
#   Font::Install{'MyFont.otf': dir => 'font/location/in/module'}
#
# Install and Remove cannot be simultaneously applied. will receive dupe
# resource error.

class fonts {
  if $::kernel == 'Linux' {
    $dir = '/usr/local/share/fonts/puppet'
  } elsif $::kernel == 'windows' {
    $dir = 'c:/windows/fonts'
  }
  file{ "$dir": ensure => directory }

  Fonts::Install{'SFMono-Bold.otf': dir => $dir}
  Fonts::Install{'SFMono-BoldItalic.otf': dir => $dir}
  Fonts::Install{'SFMono-Heavy.otf': dir => $dir}
  Fonts::Install{'SFMono-HeavyItalic.otf': dir => $dir}
  Fonts::Install{'SFMono-Light.otf': dir => $dir}
  Fonts::Install{'SFMono-LightItalic.otf': dir => $dir}
  Fonts::Install{'SFMono-Medium.otf': dir => $dir}
  Fonts::Install{'SFMono-MediumItalic.otf': dir => $dir}
  Fonts::Install{'SFMono-Regular.otf': dir => $dir}
  Fonts::Install{'SFMono-RegularItalic.otf': dir => $dir}
  Fonts::Install{'SFMono-Semibold.otf': dir => $dir}
  Fonts::Install{'SFMono-SemiboldItalic.otf': dir => $dir}
}
