class tomcat7::config {

  file { "/etc/${tomcat7::tomcat_pkg}/server.xml":
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => $tomcat7::tomcat_group,
    content => template('tomcat7/server.xml.erb'),
  }

  file { "/etc/${tomcat7::tomcat_pkg}/Catalina/localhost/manager.xml":
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => $tomcat7::tomcat_group,
    content => template('tomcat7/manager.xml.erb'),
  }

  file { "/var/lib/${tomcat7::tomcat_pkg}/bin":
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => $tomcat7::tomcat_group,
    require => Package['tomcat7'],
  }

  file { "${tomcat7::defaults}/${tomcat7::tomcat_pkg}":
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    group   => $tomcat7::tomcat_group,
    require => File ["/var/lib/${tomcat7::tomcat_pkg}/bin"],
    content => template('tomcat7/system-default-tomcat.erb'),
  }

  file { "/etc/${tomcat7::tomcat_pkg}/tomcat-users.xml":
    ensure  => file,
    mode    => '0640',
    owner   => 'root',
    group   => $tomcat7::tomcat_group,
    content => template('tomcat7/tomcat-users.xml.erb'),
  }

  file { '/etc/logrotate.d/rotatelogs-tomcat-accesslog':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('tomcat7/rotatelogs-tomcat-accesslog.erb'),
  }

}
