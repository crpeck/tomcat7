require 'spec_helper'

describe 'tomcat7', :type => 'class' do

  context "On a Debian/Ubuntu system" do

    let :facts do {
      :osfamily => 'Debian',
    } end

    it { expect contain_class('tomcat7') }
    it { expect contain_class('tomcat7::config') }
    it { expect contain_class('tomcat7::package') }
    it { expect contain_class('tomcat7::params') }
    it { expect contain_class('tomcat7::service') }

    it { expect contain_service('tomcat7') }

    describe 'config tomcat7' do
      it { expect contain_file('/etc/tomcat7/server.xml') }
      it { expect contain_file('/etc/tomcat7/tomcat-users.xml') }
      it { expect contain_file('/etc/logrotate.d/rotatelogs-tomcat-accesslog') }
      it { expect contain_file('/etc/tomcat7/Catalina/localhost/manager.xml') }
      it { expect contain_file('/etc/default/tomcat7') }
    end

    describe 'package tomcat7' do
      it { expect contain_package('tomcat7') }
      it { expect contain_package('tomcat7-admin') }
      it { expect contain_package('openjdk-7-jre-headless') }
    end

  end

  context "On a RedHat system" do

    let :facts do {
      :osfamily => 'RedHat',
    } end

    it { expect contain_package('tomcat6') }
    it { expect contain_package('tomcat6-admin-webapps') }
    it { expect contain_package('java-1.5.0-gcj') }
    it { expect contain_service('tomcat6') }

  end

end
