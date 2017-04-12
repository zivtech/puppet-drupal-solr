class drupal_solr (
  $manage_service = true,
) {

  include java
  class { "zivtech_apt": }->

  # TODO: Remove once the package is updated with this dependency.
  package { 'openjdk-8-jre': }->
  package { 'solr':
    ensure => 'present',
  }

  if ($manage_service) {
    service { 'solr':
      ensure  => 'running',
      enable  => true,
      require => Package['solr'],
    }
  }

  # TODO: Move this into a separate package?
  file { '/usr/local/bin/create-solr-instance':
    source => "puppet:///modules/${module_name}/create-solr-instance",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/usr/local/bin/remove-solr-instance':
    source => "puppet:///modules/${module_name}/remove-solr-instance",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}



