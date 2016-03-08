RSpec.describe Dory::Proxy do
  after :all do
    Dory::Proxy.delete
  end

  it "has the docker client" do
    expect(Dory::Proxy).to have_docker_client
  end

  it "starts up the container" do
    Dory::Proxy.delete
    expect(Dory::Proxy).not_to be_running
    expect{Dory::Proxy.start}.to change{Dory::Proxy.running?}.from(false).to(true)
    expect(Dory::Proxy).to be_container_exists
  end

  it "doesn't fail when starting the container twice" do
    2.times{ expect{Dory::Proxy.start}.not_to raise_error }
    expect(Dory::Proxy).to be_running
  end

  it "deletes the container" do
    expect(Dory::Proxy.start).to be_truthy
    expect(Dory::Proxy).to be_running
    expect(Dory::Proxy).to be_container_exists
    expect{Dory::Proxy.delete}.to change{Dory::Proxy.container_exists?}.from(true).to(false)
    expect(Dory::Proxy).not_to be_running
  end

  it "stops the container" do
    expect(Dory::Proxy.start).to be_truthy
    expect(Dory::Proxy).to be_running
    expect(Dory::Proxy.stop).to be_truthy
    expect(Dory::Proxy).to be_container_exists
    expect(Dory::Proxy).not_to be_running
  end

  it "starts the container when it already exists" do
    expect(Dory::Proxy.start).to be_truthy
    expect(Dory::Proxy).to be_running
    expect(Dory::Proxy.stop).to be_truthy
    expect(Dory::Proxy).to be_container_exists
    expect{Dory::Proxy.start}.to change{Dory::Proxy.running?}.from(false).to(true)
    expect(Dory::Proxy).to be_container_exists
    expect(Dory::Proxy).to be_running
  end
end
