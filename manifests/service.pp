class tomcat7::service {

  service { $tomcat7::tomcat_pkg:
    ensure => running,
    enable => true,
  }

}
