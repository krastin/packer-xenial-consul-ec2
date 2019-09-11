describe user('consul') do
    it { should exist }
    its('groups') { should eq ['redis', 'sudo'] }
    its('home') { should eq '/home/consul' }
end

describe file('/home/consul/install_consul.sh') do
    it { should exist }
    its('owner') { should eq 'consul' }
end