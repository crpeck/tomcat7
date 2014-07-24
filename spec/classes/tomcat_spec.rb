require 'spec_helper'

describe 'tomcat', :type => 'class' do

  context "On a Debian/Ubuntu system" do

    let :facts do {
      :osfamily => 'Debian',
    } end

    it { should create_class('tomcat7') }
    it { should contain_class('tomcat7::config') }
    it { should contain_class('tomcat7::package') }
    it { should contain_class('tomcat7::params') }
    it { should contain_class('tomcat7::service') }

    it { should contain_service('tomcat7') }

    describe 'config tomcat7' do
      it { should contain_group('tomcat7') }
      it { should contain_user('tomcat7') }
      it { should contain_file('/etc/tomcat7/server.xml') }
      it { should contain_file('/etc/tomcat7/tomcat-users.xml') }
      it { should contain_file('/etc/logrotate.d/rotatelogs-tomcat-accesslog') }
      it { should contain_file('/etc/tomcat7/Catalina/localhost/manager.xml') }
      it { should contain_file('/etc/defaults/tomcat7') }
    end

    describe 'package tomcat7' do
      it { should contain_package('tomcat7') }
      it { should contain_package('tomcat7-admin') }
      it { should contain_package('openjdk-7-jre-headless') }
    end

  end

  context "On a RedHat system" do

    let :facts do {
      :osfamily => 'RedHat',
    } end

    it { should contain_package('tomcat6') }
    it { should contain_package('tomcat6-admin-webapps') }
    it { should contain_package('java-1.5.0-gcj') }
    it { should contain_service('tomcat6') }

  end

end
