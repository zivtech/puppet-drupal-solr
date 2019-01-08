class drupal_solr (
  $manage_service = true,
  $version = '6.6.5',
  $checksum = '02c8eebcee7d97133234f21f0fe88960',
  $mirror = 'http://mirror.olnevhost.net/pub/apache/lucene/solr',
) {

  $downloaded_file = "solr-${version}.tgz"
  package { 'openjdk-8-jre': }

  wget::fetch { "${mirror}/${version}/${downloaded_file}":
    destination => "/tmp/${downloaded_file}",
    # Currently, cache_dir doesn't work with source_hash.
    # https://github.com/voxpupuli/puppet-wget/issues/87
    #cache_dir   => '/var/cache/wget',
    unless      => "/usr/bin/test /etc/init.d/solr",
    source_hash => $checksum,
    timeout     => 0,
    verbose     => false,
  }->
  exec { "uncompress ${downloaded_file}":
    command => "/bin/tar xzf ${downloaded_file} solr-${version}/bin/install_solr_service.sh --strip-components=2",
    cwd     => '/tmp',
    creates => "/tmp/install_solr_service.sh",
  }->
  exec { "install solr ${version}":
    command => "/tmp/install_solr_service.sh ${downloaded_file}",
    cwd     => '/tmp',
    creates => '/etc/init.d/solr',
  }

  if ($manage_service) {
    service { 'solr':
      ensure  => 'running',
      enable  => true,
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



