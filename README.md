tomcat7
=========

Travis-CI Build Status: [![Build Status](https://travis-ci.org/crpeck/tomcat7.png)](https://travis-ci.org/crpeck/tomcat7)
=========
 
A puppet module for managing single instances of tomcat.

This class installs Apache Tomcat and Tomcat Admin/Manager

Note the following are also set in the server.xml file:

```
<Valve className="org.apache.catalina.valves.RemoteIpValve"
           remoteIpHeader="x-forwarded-for"
           remoteIpProxiesHeader="x-forwarded-by"
           protocolHeader="x-forwarded-proto"
           internalProxies="$internalproxies" (if it has a value)
        />

Parameters:
  manage_serverxml - puppet manages the server.xml file, true or false
  port - port that Tomcat listens on
  ssl_port - if defined, the SSL port Tomcat listens on, setting this enables SSL
  max_threads - maxthreads setting in server.xml
  keystore_file - file that contains the java keystore for SSL
  keystore_pass - password for $keystore_file
  keystore_alias - alias associated with $keystore_file
  java_opts - options passwd to java for Tomcat
  setenv - ENVironment variables set for Tomcat process
  internalproxies - internal proxy ip's for RemoteIpValve - set for load balancer or Apache/NGINX proxy front end
  tomcat_manager - userids and their roles for Tomcat manager app
  manager_hosts - host ip's allowed access to /manager app

Actions:
  - Install Apache Tomcat and manager app
  - Manage Apache Service

Requires:

Sample Usage:

class { '::tomcat7':
  port                              => '8080',
  ssl_port                          => '8443',
  java_opts                         => [ '-Xms512M', '-Xmx1024M' ],
  keystore_file                     => '/etc/tomcat7/.keystore',
  keystore_pass                     => 'changeit',
  keystore_alias                    => 'keyalias',
  setenv                            => {
                                        tomcat_local_etc => '/etc/tomcat7',
                                        },
  tomcat_managers                   => [
                                         [ 'manager', 'manager-password', 'admin,manger-gui,manager-script,manager-status' ],
                                         [ 'nagios', 'nagios-password', 'manager-status' ],
                                       ],
  manager_hosts                     => '127\.0\.0\.1,192\.168\.*\.*,10\.\*\.*\.*',
}
```
