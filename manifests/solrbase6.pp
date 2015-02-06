
class drupal_solr::solrbase6 {
  vcsrepo { "/opt/solr/solrbase-6":
    require => [
      File['/opt/solr'],
      Package['tomcat6'],
    ],
    ensure => present,
    provider => 'git',
    source => "https://github.com/zivtech/Solr-base.git",
    revision => '04117b5d52391eea48b5f8aa71d3b88ca788e9f1',
    before => [
      File['/usr/local/bin/create-solr-instance'],
      File['/usr/local/bin/remove-solr-instance'],
    ],
  }
}
