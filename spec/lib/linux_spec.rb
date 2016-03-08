RSpec.describe Dory::Linux do
  it "knows we're on ubuntu" do
    expect(Dory::Linux.ubuntu?).to be_truthy
    expect(Dory::Linux.fedora?).to be_falsey
    expect(Dory::Linux.arch?).to be_falsey
    expect(Dory::Linux.osx?).to be_falsey
  end
end
