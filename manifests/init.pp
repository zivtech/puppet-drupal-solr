class drupal_solr (
  $user = 'tomcat6',
  $group = 'root',
  $manage_service = true,
  $solr_drupal_6_ref = '04117b5d52391eea48b5f8aa71d3b88ca788e9f1',
  $solr_drupal_7_ref = '072b12bd14e6029531609b8a81b3beab35f0b9e7',
  $solr_drupal_7_sapi_ref = '80e7f0e343f47364ee707dc10ef3b8994784bd7c'
) {

  package { 'tomcat6':
    ensure => 'installed'
  }

  package { 'tomcat6-admin':
    ensure => 'installed'
  }

  if ($manage_service) {
    service { 'tomcat6':
      require => Package['tomcat6'],
      ensure  => 'running',
    }
  }

  logrotate::rule { 'tomcat':
    path         => '/var/log/tomcat/catalina.out',
    copytruncate => true,
    rotate_every => 'day',
    rotate       => 5,
    compress     => true,
    missingok    => true,
    size         => '10M'
  }

  file { '/opt/solr':
    require => Package['tomcat6'],
    ensure  => 'directory',
    owner   => $user,
    group   => $group,
    mode    => '0775',
  }

  vcsrepo { '/opt/solr/solrbase-6':
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/zivtech/Solr-base.git',
    revision => $solr_drupal_6_ref,
    owner    => $user,
    group    => $group,
    require  => [
      File['/opt/solr'],
      Package['tomcat6'],
    ],
  }

  vcsrepo { '/opt/solr/solrbase-7':
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/zivtech/Solr-base.git',
    revision => $solr_drupal_7_ref,
    owner    => $user,
    group    => $group,
    require  => [
      File['/opt/solr'],
      Package['tomcat6']
    ],
  }

  vcsrepo { '/opt/solr/sapi-solrbase-7':
    source   => 'https://github.com/zivtech/Solr-base.git',
    ensure   => 'present',
    provider => 'git',
    revision => $solr_drupal_7_sapi_ref,
    owner    => $user,
    group    => $group,
    require  => [
      File['/opt/solr'],
      Package['tomcat6']
    ],
  }

  file { '/usr/local/bin/create-solr-instance':
    source => 'puppet:///modules/solr/create-solr-instance',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/usr/local/bin/remove-solr-instance':
    source => 'puppet:///modules/solr/remove-solr-instance',
    owner  => 'root',
    group  => 'root',
    mode  => '0755',
  }

  file { '/etc/tomcat6/Catalina/localhost':
    ensure  => 'directory',
    owner   => 'root',
    group   => $webadmingroup,
    require => [
      Package['tomcat6'],
    ],
  }

  file { '/var/lib/tomcat6/webapps':
    ensure => 'directory',
    owner  => $tomcatuser,
    group  => $webadmingroup,
  }
}



