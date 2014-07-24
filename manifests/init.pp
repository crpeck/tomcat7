# Class: tomcat
#
# This class installs Apache Tomcat and Tomcat Admin/Manager
# Note the following are also set in the server.xml file:
#<Valve className="org.apache.catalina.valves.RemoteIpValve"
#           remoteIpHeader="x-forwarded-for"
#           remoteIpProxiesHeader="x-forwarded-by"
#           protocolHeader="x-forwarded-proto"
#           internalProxies="$internalproxies" (if it has a value)
#        />
#
# Parameters:
#   port - port that Tomcat listens on
#   ssl_port - if defined, the SSL port Tomcat listens on, setting this enables SSL
#   max_threads - maxthreads setting in server.xml
#   keystore_file - file that contains the java keystore for SSL
#   keystore_pass - password for $keystore_file
#   keystore_alias - alias associated with $keystore_file
#   java_opts - options passwd to java for Tomcat
#   setenv - ENVironment variables set for Tomcat process
#   internalproxies - internal proxy ip's for RemoteIpValve - set for load balancer or Apache/NGINX proxy front end
#   tomcat_manager - userids and their roles for Tomcat manager app
#   manager_hosts - host ip's allowed access to /manager app
#
# Actions:
#   - Install Apache Tomcat and manager app
#   - Manage Apache Service
#
# Requires:
#
# Sample Usage:
#
#  class { '::tomcat':
#    port                              => '8080',
#    ssl_port                          => '8443',
#    java_opts                         => [ '-Xms512M', '-Xmx1024M' ],
#    keystore_file                     => '/etc/tomcat7/.keystore',
#    keystore_pass                     => 'changeit',
#    keystore_alias                    => 'keyalias',
#    setenv                            => {
#                                          tomcat_local_etc => '/etc/tomcat7',
#                                          },
#    tomcat_managers                   => [
#                                           [ 'manager', 'manager-password', 'admin,manger-gui,manager-script,manager-status' ],
#                                           [ 'nagios', 'nagios-password', 'manager-status' ],
#                                         ],
#    manager_hosts                     => '127\.0\.0\.1,192\.168\.*\.*,10\.\*\.*\.*',
#  }


class tomcat (
  $port            = $tomcat7::params::port,
  $ssl_port        = $tomcat7::params::ssl_port,
  $max_threads     = $tomcat7::params::max_threads,
  $keystore_file   = $tomcat7::params::keystore_file,
  $keystore_pass   = $tomcat7::params::keystore_pass,
  $keystore_alias  = $tomcat7::params::keystore_alias,
  $java_opts       = $tomcat7::params::java_opts,
  $setenv          = $tomcat7::params::setenv,
  $internalproxies = $tomcat7::params::internalproxies,
  $tomcat_managers = $tomcat7::params::tomcat_managers,
  $manager_hosts   = $tomcat7::params::manager_hosts,
) inherits tomcat7::params {

  validate_hash($setenv)
  validate_string($internalproxies, $keystore_file, $keystore_pass, $keystore_alias, $manager_hosts, $max_threads, $port, $ssl_port)
  validate_array($java_opts, $tomcat_managers)

  if $::osfamily == 'Debian' {
    $tomcat_pkg       = 'tomcat7'
    $tomcat_admin_pkg = 'tomcat7-admin'
    $java_pkg         = 'openjdk-7-jre-headless'
    $defaults         = '/etc/default'
    $tomcat_group     = $tomcat_pkg
    $tomcat_user      = $tomcat_pkg
  } elsif $::osfamily == 'RedHat' {
    $tomcat_pkg       = 'tomcat6'
    $tomcat_admin_pkg = 'tomcat6-admin-webapps'
    $java_pkg         = 'java-1.5.0-gcj'
    $defaults         = '/etc/sysconfig'
    $tomcat_group     = 'tomcat'
    $tomcat_user      = 'tomcat'
  }  else {
    fail('Your operating system isn\'t supported by this tomcat module.')
  }

  validate_string($tomcat_pkg, $tomcat_admin_pkg, $java_pkg, $defaults, $tomcat_group, $tomcat_user)

  include tomcat7::package
  include tomcat7::config
  include tomcat7::service

  anchor { 'tomcat_start': } ->
  Class [ 'tomcat7::package' ] ->
  Class [ 'tomcat7::config' ] ->
  Class [ 'tomcat7::service' ] ->
  anchor { 'tomcat_end': }

}
