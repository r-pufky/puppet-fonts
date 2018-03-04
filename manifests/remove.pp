# Remove a given font resource.
#
# Args:
#   title: String filename of the font to remove.
#   dir: String target font installation directory.
#

define fonts::remove($file = $title, $dir) {
  case $::kernel {
    'Linux': {
      file { "${dir}/${file}":
        ensure => 'absent',
        path   => "${dir}/${file}",
        notify => Exec["refresh-${file}"],
        mode => '0644',
      } ~>
      exec { "refresh-${file}":
        path => '/bin:/usr/bin',
        command => 'fc-cache -f -v',
      }
    }
    
    'windows': {
      # Windows. Because fuck you. Fonts shouldn't be this hard.
      #
      # Because we can't run in a user context, removal of fonts is hard
      # and must be done in this order:
      #
      # 1) Set the given registry key to an empty value (since we cannot delete
      #    that registry key via puppet (reg module or exec command).
      # 2) Reboot the windows machine. This will remove the system lock on the
      #    font file, since it now does not know where to look for that font.
      # 3) Delete the font file from c:\windows\fonts.
      # 4) Delete the registry key (ok to just leave blank, I guess).
      #
      # This is accomplished by doing the following steps, and using a
      # scheduled job with a self-deleting powershell script to clean up the
      # font file and registry key on machine reboot.
      registry::value { "${file}":
        key => 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\Fonts',
        data => '',
      } ->
      file { "$common::staging/${file}-remove.ps1":
        ensure => 'file',
        content => epp('fonts/windows_remove.ps1.epp', { 'file' => $file, 'dir' => $dir })
      } ~>
      exec { "schedule-${file}-remove":
        command => "\$Startup = New-JobTrigger -AtStartup -RandomDelay 00:00:30; \$Options = New-ScheduledJobOption -StartIFOnBattery -StopIfGoingOnBattey:\$False -WakeToRun:\$False -StartIfNotIdle -StopIfGoingOffIdle:\$False -ShowInTaskScheduler -RunElevated -RunWithoutNetwork; Register-ScheduledJob -Trigger \$Startup -FilePath '${common::staging}/${file}-remove.ps1' -Name 'Remove-${file}' -ScheduledJobOption \$Options",
        provider => powershell,
      }
    }

    default: {
      info('Operating system not supported.')
    }
  }
}
