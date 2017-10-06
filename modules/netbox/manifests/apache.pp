# == Class: ::dc_netbox::apache
#

class dc_netbox::apache {

  include ::apache
  include ::apache::mod::proxy
  include ::apache::mod::proxy_http
  include ::apache::mod::wsgi
  include ::apache::mod::ssl
  include ::puppetcrl_sync

  apache::vhost { "${::fqdn} nonssl":
    servername              => $::fqdn,
    port                    => '80',
    ssl                     => false,
    default_vhost           => true,
    manage_docroot          => false,
    docroot                 => $dc_netbox::static_dir_link,
    docroot_owner           => 'www-data',
    docroot_group           => 'www-data',
    options                 => ['Indexes','FollowSymLinks','MultiViews'],
    proxy_preserve_host     => on,
    wsgi_pass_authorization => on,
    custom_fragment         => 'ProxyPreserveHost On',
    aliases                 => [
      {
        alias => $dc_netbox::static_dir_link,
        path  => $dc_netbox::static_dir,
      },
    ],
    proxy_pass              => [
      {
        path => $dc_netbox::static_dir_link,
        url  => '!'
      },
      {
      path => '/',
      url  => $dc_netbox::gunicorn_url
      },
    ],
    rewrites                => [
      {
      comment      => 'redirect all to https',
      rewrite_cond => ['%{SERVER_PORT} !^443$'],
      rewrite_rule => ["^/(.*)$ https://${::fqdn}/\$1 [L,R]"],
      }
    ],
  }

  apache::vhost { "${::fqdn} ssl":
    servername              => $::fqdn,
    port                    => '443',
    ssl                     => true,
    docroot                 => $dc_netbox::static_dir_link,
    docroot_owner           => 'www-data',
    docroot_group           => 'www-data',
    options                 => ['Indexes','FollowSymLinks','MultiViews'],
    proxy_preserve_host     => on,
    wsgi_pass_authorization => on,
    custom_fragment         => 'ProxyPreserveHost On',
    ssl_cert                => $dc_netbox::ssl_cert,
    ssl_key                 => $dc_netbox::ssl_key,
    ssl_ca                  => $dc_netbox::ssl_cacert,
    ssl_crl                 => $dc_netbox::ssl_crl,
    #     ssl_verify_client - when deployed and certs changed replace optional => require
    ssl_verify_client       => 'require',
    ssl_verify_depth        => 1,
    aliases                 => [
      {
        alias => $dc_netbox::static_dir_link,
        path  => $dc_netbox::static_dir,
      },
    ],
    proxy_pass              => [
      {
        path => $dc_netbox::static_dir_link,
        url  => '!'
      },
      {
        path => '/',
        url  => $dc_netbox::gunicorn_url
      },
    ],
  }
}
