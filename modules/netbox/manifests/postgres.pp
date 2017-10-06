# == Class: ::dc_netbox::postgres
#

class dc_netbox::postgres {

  include ::postgresql::globals
  include ::postgresql::server
  include ::postgresql::lib::devel
  include ::postgresql::lib::python

  Class['::postgresql::globals']->
  Class['::postgresql::server']->
  Class['::postgresql::lib::devel']->
  Class['::postgresql::lib::python']

  postgresql::server::db { $dc_netbox::db_name:
    password => postgresql_password($dc_netbox::db_user, $dc_netbox::db_pass),
    user     => $dc_netbox::db_user,
    grant    => 'all',
  }
}
