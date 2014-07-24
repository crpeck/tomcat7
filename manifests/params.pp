class tomcat7::params {
  $port           = '8080'
  $max_threads    = '200'
  $java_opts      = [ '-Xms128M',
                      '-Xmx256M' ]
  # Variables must be named in lower case
  # They will be uppercased in the environment (limitation of ruby hashes)
  $setenv         = { my_tomcat_home => '/var/lib/tomcat', }
  $manager_hosts  = [ '127\.0\.0\.1' ]
}
