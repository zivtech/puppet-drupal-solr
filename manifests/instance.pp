
define drupal_solr::instance(
  $ensure = present,
  $version = 7,
  $sapi = true,
) {
  case $version {
    6: {
      if $sapi {
        fail("\$sapi only supported with Drupal 7.")
      }
    }
    7: {}
    default: { fail("Invalid Drupal version ${version} detected. Only 6 and 7 supported.") }
  }

  case $ensure {
    present: {
      case $sapi {
        true: { $command = "create-solr-instance ${name} ${version} sapi" }
        false: { $command = "create-solr-instance ${name} ${version}" }
        default: { fail("Invalid value for \$sapi: must be a boolean.") }
      }

      exec { $command:
        require => File['/usr/local/bin/create-solr-instance'],
        user => 'root',
        path => ['/bin', '/usr/bin', '/usr/local/bin'],
        unless => "test -d /opt/solr/solr-${name}",
      }
    }
    absent: {
      exec { "remove-solr-instance ${name}":
        require => File['/usr/local/bin/remove-solr-instance'],
        user => 'root',
        path => ['/bin', '/usr/bin', '/usr/local/bin'],
        onlyif => "test -d /opt/solr/solr-${name}",
      }
    }
    default: { fail("Unrecognised value for ensure.")}
  }
}
