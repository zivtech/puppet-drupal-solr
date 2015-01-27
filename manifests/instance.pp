
define drupal_solr::instance(
  $ensure = present,
) {
  case $ensure {
    present: {
      exec { "/bin/bash /usr/local/bin/create-solr-instance ${name} 7 sapi":
        require => File['/usr/local/bin/create-solr-instance'],
        user => 'root',
      }
    }
    absent: {
      exec { "/bin/bash /usr/local/bin/remove-solr-instance ${name}":
        require => File['/usr/local/bin/remove-solr-instance'],
        user => 'root',
      }
    }
    default: { fail("Unrecognised value for ensure.")}
  }
}
