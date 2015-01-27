# Drupal Solr

This project sets up an instance of Solr configured to run with SOLR.

It installs SOLR on tomcat6 on Ubuntu based systems. Patches to support other
architectures are welcome.  Patches to add testing are especially welcome.

## Installation

Just run `puppet module install zivtech/drupal_solr`.

## Basic usage

```` puppet
    include drupal_solr
````

## Advanced usage

```` puppet
    class { 'drupal_solr':
      tomcatuser => 'tomcat6',
      webadmingroup => 'some_website_admin_group',
    }
````

## Dependencies

This module relies on
 [puppetlabs/vcsrepo](https://forge.puppetlabs.com/puppetlabs/vcsrepo).

## Creating a solr instance

```` puppet
    drupal_solr::instance { 'drupal': }
````

## Advanced solr instances

```` puppet
    drupal_solr::instance { 'drupal':
      # Drupal 7
      version => 7,
      # Not using Search API
      sapi => false,
    }
````

## Removing a solr instance

```` puppet
    drupal_solr::instance { 'drupal': ensure => absent }
````
