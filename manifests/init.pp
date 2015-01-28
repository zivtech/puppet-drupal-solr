class drupal_solr (
  $tomcatuser = 'tomcat6',
  $webadmingroup = 'root',
  $manage_service = true,
) {

  package {
    [
      'tomcat6',
      'tomcat6-admin',
    ]:
      ensure => installed
  }

  if ($manage_service) {
    service { 'tomcat6':
      require => Package['tomcat6'],
      ensure => running,
      subscribe => [
        File['/etc/tomcat6/Catalina/localhost'],
        File['/var/lib/tomcat6/webapps'],
      ],
    }
    -> File['/usr/local/bin/create-solr-instance']
    -> File['/usr/local/bin/remove-solr-instance']
  }

  file { "/opt/solr":
    require => Package['tomcat6'],
    ensure => directory,
    owner => $tomcatuser,
    group => $webadmingroup,
    recurse => true,
    mode => 775,
  }

  file { '/usr/local/bin/create-solr-instance':
    source => "puppet:///modules/drupal_solr/create-solr-instance",
    owner => 'root',
    group => 'root',
    mode => 755,
  }

  file { '/usr/local/bin/remove-solr-instance':
    source => "puppet:///modules/drupal_solr/remove-solr-instance",
    owner => 'root',
    group => 'root',
    mode => 755,
  }

  file { '/etc/tomcat6/Catalina/localhost':
    ensure => directory,
    owner => root,
    group => $webadmingroup,
    require => [
      Package['tomcat6'],
    ],
  }

  file { '/var/lib/tomcat6/webapps':
    ensure => directory,
    owner => $tomcatuser,
    group => $webadmingroup,
  }
}
