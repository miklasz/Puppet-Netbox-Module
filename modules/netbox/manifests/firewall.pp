# == Class: ::dc_netbox::firewall
#

class dc_netbox::firewall (
  Hash $firewall,
){

  include ::firewall

  create_resources(firewall, $firewall['base'])
  create_resources(firewall, $firewall['netbox'])
  create_resources(firewall, $firewall['drop'])

}
