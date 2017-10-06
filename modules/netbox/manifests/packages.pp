# == Class: ::dc_netbox::packages
#

class dc_netbox::packages {

  include ::python

  ensure_packages($dc_netbox::requirements)

  Package['libffi-dev'] -> Class['python']

}
