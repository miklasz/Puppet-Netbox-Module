# == Class: ::dc_netbox::backup
#

class dc_netbox::backup (
  Hash $config,
){

  include ::dc_backup

  create_resources('dc_backup::dc_duplicity_job', $config)

}
