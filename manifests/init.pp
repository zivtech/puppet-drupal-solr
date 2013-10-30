class solr ( $tomcatuser = 'tomcat6', $webadmingroup = 'root') {

  package {
    [
      'tomcat6',
      'tomcat6-admin',
    ]:
      ensure => installed
  }

  service { 'tomcat6':
    require => Package['tomcat6'],
    ensure => running,
  }

  file { "/opt/solr":
    require => Package['tomcat6'],
    ensure => directory,
    owner => $tomcatuser,
    group => $webadmingroup,
    recurse => true,
    mode => 775,
  }

  vcsrepo { "/opt/solr/solrbase-6":
    require => [
      File['/opt/solr'],
      Package['tomcat6'],
    ],
    ensure => present,
    provider => 'git',
    source => "https://github.com/zivtech/Solr-base.git",
    revision => '04117b5d52391eea48b5f8aa71d3b88ca788e9f1',
  }

  vcsrepo { "/opt/solr/solrbase-7":
    require => [
      File['/opt/solr'],
      Package['tomcat6']
    ],
    ensure => present,
    provider => 'git',
    source => "https://github.com/zivtech/Solr-base.git",
    revision => '072b12bd14e6029531609b8a81b3beab35f0b9e7',
  }

  vcsrepo { "/opt/solr/sapi-solrbase-7":
    require => [
      File['/opt/solr'],
      Package['tomcat6']
    ],
    source => "https://github.com/zivtech/Solr-base.git",
    ensure => "present",
    provider => 'git',
    revision => '80e7f0e343f47364ee707dc10ef3b8994784bd7c',
  }

  file { '/usr/local/bin/create-solr-instance':
    source => "puppet:///modules/solr/create-solr-instance",
    owner => 'root',
    group => 'root',
    mode => 755,
  }

  file { '/usr/local/bin/remove-solr-instance':
    source => "puppet:///modules/solr/remove-solr-instance",
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



