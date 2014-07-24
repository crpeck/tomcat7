class tomcat7::package {

  package { $tomcat7::java_pkg:
    ensure => latest,
  }

  package { $tomcat7::tomcat_pkg:
    ensure  => latest,
    require => Package[$tomcat7::java_pkg],
  }

  package { $tomcat7::tomcat_admin_pkg:
    ensure  => latest,
    require => Package[$tomcat7::tomcat_pkg],
  }
}
