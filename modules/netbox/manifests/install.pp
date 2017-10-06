# == Class: ::dc_netbox::install
#

class dc_netbox::install {

  # Local variables for
  # - configuration.py.crb, dc_netbox::netbox_config
  # - superuser.sh.crb, dc_netbox::suser_config
  $_db_name     = $dc_netbox::db_name
  $_db_user     = $dc_netbox::db_user
  $_db_pass     = $dc_netbox::db_pass
  $_secretkey   = $dc_netbox::secretkey
  $_admin_name  = $dc_netbox::admin_name
  $_admin_email = $dc_netbox::admin_email
  $_admin_suser = $dc_netbox::admin_suser
  $_admin_pass  = $dc_netbox::admin_pass

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $dc_netbox::netbox_dir:
    ensure => 'directory',
  }

  archive { "netbox-${dc_netbox::netbox_ver}.tar.gz":
    source          => $dc_netbox::netbox_tar,
    path            => "/tmp/netbox-${dc_netbox::netbox_ver}.tar.gz",
    extract_command => 'tar xzf %s --strip-components=1',
    extract_path    => $dc_netbox::netbox_dir,
    extract         => true,
  }

  runonce { 'pip_upgrade_to_9_0':
    command => 'pip install --upgrade pip',
  }

  runonce { 'install_pip_requirement':
    command => '/usr/bin/pip install -r requirements.txt',
    cwd     => $dc_netbox::netbox_dir,
  }

  file { $dc_netbox::netbox_config:
    content => template($dc_netbox::config_template),
  }

  runonce { 'build_netbox_db':
    command => '/usr/bin/python manage.py migrate',
    cwd     => $dc_netbox::manage_dir,
  }

  runonce { 'collect_netbox_static':
    command => '/usr/bin/python manage.py collectstatic --no-input',
    cwd     => $dc_netbox::manage_dir,
  }

  runonce { 'load_netbox_initial_data':
    command => '/usr/bin/python manage.py loaddata initial_data',
    cwd     => $dc_netbox::manage_dir,
  }

  file { $dc_netbox::suser_config:
    content => template($dc_netbox::suser_template),
    mode    => '0755',
  }

  runonce { 'create_django_superuser':
    command => "${dc_netbox::manage_dir}/superuser.sh",
  }

  file { $dc_netbox::gunicorn_config:
    content => template($dc_netbox::gunicorn_template),
  }

  file { $dc_netbox::netbox_backup_sh:
    content => template($dc_netbox::netbox_backup_template),
    mode    => '0755',
  }
}
