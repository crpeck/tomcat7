require 'spec_helper'

describe 'tomcat', :type => 'class' do

  context "On a Debian/Ubuntu system" do

    let :facts do {
      :osfamily => 'Debian',
    } end

    it { should contain_package('tomcat7') }
    it { should contain_package('openjdk-7-jre-headless') }
    it { should contain_service('tomcat7') }

  end

  context "On a RedHat system" do

    let :facts do {
      :osfamily => 'RedHat',
    } end

    it { should contain_package('tomcat6') }
    it { should contain_package('java-1.5.0-gcj') }
    it { should contain_service('tomcat6') }

  end

end
