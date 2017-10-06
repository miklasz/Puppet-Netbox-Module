# == Class: ::dc_netbox::manage
#

class dc_netbox::manage {

  file { $dc_netbox::supervisor_config:
    content => template($dc_netbox::supervisor_template),
  }~>

  service { 'supervisor':
    ensure => running,
    name   => 'supervisor',
    enable => true,
  }
}
