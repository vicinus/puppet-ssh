# Class ssh::hostkeys
class ssh::hostkeys {
  $ipaddresses  = ipaddresses()
  $host_aliases = flatten([ $::fqdn, $::hostname, $ipaddresses ])

  if getvar('sshdsakey') {
    @@sshkey { "${::fqdn}_dsa":
      ensure       => present,
      host_aliases => $host_aliases,
      type         => dsa,
      key          => $::sshdsakey,
    }
  } else {
    @@sshkey { "${::fqdn}_dsa":
      ensure => absent,
    }
  }
  if getvar('sshrsakey') {
    @@sshkey { "${::fqdn}_rsa":
      ensure       => present,
      host_aliases => $host_aliases,
      type         => rsa,
      key          => $::sshrsakey,
    }
  } else {
    @@sshkey { "${::fqdn}_rsa":
      ensure => absent,
    }
  }
  if getvar('sshecdsakey') {
    @@sshkey { "${::fqdn}_ecdsa":
      ensure       => present,
      host_aliases => $host_aliases,
      type         => 'ecdsa-sha2-nistp256',
      key          => $::sshecdsakey,
    }
  } else {
    @@sshkey { "${::fqdn}_ecdsa":
      ensure => absent,
      type   => 'ecdsa-sha2-nistp256',
    }
  }
  if getvar('sshed25519key') {
    @@sshkey { "${::fqdn}_ed25519":
      ensure       => present,
      host_aliases => $host_aliases,
      type         => 'ed25519',
      key          => $::sshed25519key,
    }
  } else {
    @@sshkey { "${::fqdn}_ed25519":
      ensure => absent,
      type   => 'ed25519',
    }
  }
}
