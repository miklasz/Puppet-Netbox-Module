# == Class: ::dc_netbox::params
#

class dc_netbox::params {
  $admin_suser            = 'admin'
  $admin_name             = ''
  $admin_email            = ''
  $db_name                = 'netbox'
  $db_user                = 'netbox'
  $netbox_dir             = '/opt/netbox/'
  $manage_dir             = '/opt/netbox/netbox'
  $static_dir             = '/opt/netbox/netbox/static'
  $static_dir_link        = '/static'
  $netbox_ver             = '2.0.7'
  $netbox_tar             = "https://github.com/digitalocean/netbox/archive/v${netbox_ver}.tar.gz"
  $netbox_config          = '/opt/netbox/netbox/netbox/configuration.py'
  $config_template        = 'dc_netbox/configuration.py.erb'
  $suser_config           = '/opt/netbox/netbox/superuser.sh'
  $suser_template         = 'dc_netbox/superuser.sh.erb'
  $gunicorn_config        = '/opt/netbox/gunicorn_config.py'
  $gunicorn_template      = 'dc_netbox/gunicorn_config.py.erb'
  $gunicorn_url           = 'http://127.0.0.1:8001/'
  $supervisor_config      = '/etc/supervisor/conf.d/netbox.conf'
  $supervisor_template    = 'dc_netbox/supervisor.conf.erb'
  $netbox_backup_sh       = '/opt/netbox/netbox-backup.sh'
  $netbox_backup_template = 'dc_netbox/netbox-backup.sh.erb'
  $ssl_key                = "/etc/puppetlabs/puppet/ssl/private_keys/${::fqdn}.pem"
  $ssl_cert               = "/etc/puppetlabs/puppet/ssl/certs/${::fqdn}.pem"
  $ssl_cacert             = '/etc/puppetlabs/puppet/ssl/certs/ca.pem'
  $ssl_crl                = '/etc/puppetlabs/puppet/ssl/crl.pem'
  $requirements           = ['supervisor', 'libffi-dev', 'libssl-dev']
}
