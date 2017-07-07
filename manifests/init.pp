class drupal_solr (
  $manage_service = true,
) {

  class { 'zivtech_apt': }

  package { 'openjdk-8-jre': }

  exec { 'solr-apt-update':
    command     => '/usr/bin/apt update',
    refreshonly => true,
  }

  package { 'solr':
    ensure  => 'present',
    require => [
      Package['openjdk-8-jre'],
    ],
  }

  Class['zivtech_apt']~>Exec['solr-apt-update']->Package['solr']

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



