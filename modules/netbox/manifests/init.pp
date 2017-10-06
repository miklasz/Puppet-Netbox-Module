# == Class: dc_netbox
#

class dc_netbox (
  $db_pass,
  $secretkey,
  $admin_pass,
  $admin_suser            = $dc_netbox::params::admin_suser,
  $admin_email            = $dc_netbox::params::admin_email,
  $requirements           = $dc_netbox::params::requirements,
  $db_user                = $dc_netbox::params::db_user,
  $db_name                = $dc_netbox::params::db_name,
  $netbox_dir             = $dc_netbox::params::netbox_dir,
  $manage_dir             = $dc_netbox::params::manage_dir,
  $netbox_ver             = $dc_netbox::params::netbox_ver,
  $netbox_tar             = $dc_netbox::params::netbox_tar,
  $netbox_config          = $dc_netbox::params::netbox_config,
  $config_template        = $dc_netbox::params::config_template,
  $suser_config           = $dc_netbox::params::suser_config,
  $suser_template         = $dc_netbox::params::suser_template,
  $gunicorn_config        = $dc_netbox::params::gunicorn_config,
  $gunicorn_template      = $dc_netbox::params::gunicorn_template,
  $supervisor_config      = $dc_netbox::params::supervisor_config,
  $supervisor_template    = $dc_netbox::params::supervisor_template,
  $netbox_backup_sh       = $dc_netbox::params::netbox_backup_sh,
  $netbox_backup_template = $dc_netbox::params::netbox_backup_template,
  $static_dir             = $dc_netbox::params::static_dir,
  $gunicorn_url           = $dc_netbox::params::gunicorn_url,
  $static_dir_link        = $dc_netbox::params::static_dir_link,
  $ssl_key                = $dc_netbox::params::ssl_key,
  $ssl_cert               = $dc_netbox::params::ssl_cert,
  $ssl_cacert             = $dc_netbox::params::ssl_cacert,
  $ssl_crl                = $dc_netbox::params::ssl_crl,
) inherits dc_netbox::params {

  include ::dc_netbox::params
  include ::dc_netbox::packages
  include ::dc_netbox::postgres
  include ::dc_netbox::install
  include ::dc_netbox::manage
  include ::dc_netbox::apache
  include ::dc_netbox::firewall
  include ::dc_netbox::backup

  Class['::dc_netbox::params'] ->
  Class['::dc_netbox::packages'] ->
  Class['::dc_netbox::postgres'] ->
  Class['::dc_netbox::install'] ->
  Class['::dc_netbox::apache'] ->
  Class['::dc_netbox::manage'] ->
  Class['::dc_netbox::firewall'] ->
  Class['::dc_netbox::backup']
}
