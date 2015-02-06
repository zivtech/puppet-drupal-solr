
class drupal_solr::solrbase7_sapi {
  vcsrepo { "/opt/solr/sapi-solrbase-7":
    require => [
      File['/opt/solr'],
      Package['tomcat6'],
    ],
    ensure => present,
    provider => 'git',
    source => "https://github.com/zivtech/Solr-base.git",
    revision => '80e7f0e343f47364ee707dc10ef3b8994784bd7c',
    before => [
      File['/usr/local/bin/create-solr-instance'],
      File['/usr/local/bin/remove-solr-instance'],
    ],
  }
}
