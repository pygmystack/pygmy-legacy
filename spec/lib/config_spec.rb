RSpec.describe Dory::Config do
  let(:filename) { '/tmp/dory-test-config-yml' }

  let(:ssl_certs_dir) { '/usr/bin' }
  let(:proxy_container_name) { 'dory_dinghy_http_proxy_test_name' }
  let(:overridden_proxy_container_name) { 'some_container_name' }

  let(:default_config) do
    %Q(
      ---
      :dory:
        :dnsmasq:
          :enabled: true
          :domain: docker_test_name
          :address: 192.168.11.1
          :container_name: dory_dnsmasq_test_name
        :nginx_proxy:
          :enabled: true
          :ssl_certs_dir: #{ssl_certs_dir}
          :container_name: #{proxy_container_name}
        :resolv:
          :enabled: true
          :nameserver: 192.168.11.1
    ).split("\n").map{|s| s.sub(' ' * 6, '')}.join("\n")
  end

  let(:incomplete_config) do
    %Q(
      ---
      :dory:
        :dnsmasq:
          :enabled: true
          :domain: docker_test_name
          :address: 192.168.11.1
          :container_name: dory_dnsmasq_test_name
        :nginx_proxy:
          :enabled: true
          :container_name: #{overridden_proxy_container_name}
        :resolv:
          :enabled: true
          :nameserver: 192.168.11.1
    ).split("\n").map{|s| s.sub(' ' * 6, '')}.join("\n")
  end

  before :each do
    allow(Dory::Config).to receive(:filename) { filename }
    allow(Dory::Config).to receive(:default_yaml) { default_config }
  end

  after :each do
    File.delete(filename) if File.exist?(filename)
  end

  it "let's you override settings" do
    Dory::Config.write_default_settings_file
    test_addr = "3.3.3.3"
    new_config = YAML.load(default_config)
    new_config[:dory][:dnsmasq][:address] = test_addr
    Dory::Config.write_settings(new_config, filename, is_yaml: false)
    expect(File.exist?(filename)).to be_truthy
    expect(Dory::Config.settings[:dory][:dnsmasq][:address]).to eq(test_addr)
    expect(Dory::Config.settings[:dory][:dnsmasq][:domain]).to eq('docker_test_name')
  end

  it "doesn't squash defaults if they're missing in the config file" do
    Dory::Config.write_settings(incomplete_config, filename, is_yaml: true)
    expect(File.exist?(filename)).to be_truthy

    settings = Dory::Config.default_settings
    expect(settings[:dory][:nginx_proxy].keys).to include(:ssl_certs_dir)
    expect(settings[:dory][:nginx_proxy][:ssl_certs_dir]).to eq(ssl_certs_dir)
    expect(settings[:dory][:nginx_proxy][:container_name]).to eq(proxy_container_name)

    settings = Dory::Config.settings
    expect(settings[:dory][:nginx_proxy].keys).to include(:ssl_certs_dir)
    expect(settings[:dory][:nginx_proxy][:ssl_certs_dir]).to eq(ssl_certs_dir)
    expect(settings[:dory][:nginx_proxy][:container_name]).to eq(overridden_proxy_container_name)
  end
end
