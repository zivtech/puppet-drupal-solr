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
  user => 'tomcat6',
  group => 'some_website_admin_group',
}
````

## Dependencies

This module relies on
 [puppetlabs/vcsrepo](https://forge.puppetlabs.com/puppetlabs/vcsrepo) and [rodjek/logrotate](https://github.com/rodjek/puppet-logrotate).

## Using the setup once installed

### Creating a solr instance

This module supports creating multiple solr instances all of which are added to
and managed by tomcat.  Once you use this module to install solr you can create
specific instances like so:

```` bash
create-solr-instance mysite 7 sapi
````

This will create a solr instance with the
[search_api](http://drupal.org/project/search_api) schema appropriate for Drupal
7.

### Removing a solr instance

You can remove the solr instance from tomcat and delete all data inside the index
with the following command:

```` bash
remove-solr-instance mysite
````

