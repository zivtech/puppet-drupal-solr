
class drupal_solr::solrbase7 {
  vcsrepo { "/opt/solr/solrbase-7":
    require => [
      File['/opt/solr'],
      Package['tomcat6'],
    ],
    ensure => present,
    provider => 'git',
    source => "https://github.com/zivtech/Solr-base.git",
    revision => '072b12bd14e6029531609b8a81b3beab35f0b9e7',
    before => [
      File['/usr/local/bin/create-solr-instance'],
      File['/usr/local/bin/remove-solr-instance'],
    ],
  }
}
