
define drupal_solr::instance(
  $ensure = present,
) {
  case $ensure {
    present: {
      exec { "create-solr-instance ${name} 7 sapi":
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
