RSpec.describe Dory::Config do
  let(:filename) { '/tmp/dory-test-config-yml' }
  let(:default_config) do
    %q(
      ---
      :dory:
        :dnsmasq:
          :enabled: true
          :domain: docker_test_name
          :address: 192.168.11.1
          :container_name: dory_dnsmasq_test_name
        :nginx_proxy:
          :enabled: true
          :container_name: dory_dinghy_http_proxy_test_name
        :resolv:
          :enabled: true
          :nameserver: 192.168.11.1
    ).split("\n").map{|s| s.sub(' ' * 6, '')}.join("\n")
  end

  before :each do
    allow(Dory::Config).to receive(:default_yaml) { default_config }
    allow(Dory::Config).to receive(:filename) { filename }
  end

  it "let's you override settings" do
    test_addr = "3.3.3.3"
    new_config = YAML.load(default_config)
    new_config[:dory][:dnsmasq][:address] = test_addr
    allow(Dory::Config).to receive(:default_yaml) { new_config.to_yaml }
    expect(Dory::Config.settings[:dory][:dnsmasq][:address]).to eq(test_addr)
    expect(Dory::Config.settings[:dory][:dnsmasq][:domain]).to eq('docker_test_name')
  end
end
