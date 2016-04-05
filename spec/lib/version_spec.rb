require 'spec_helper'

RSpec.describe Dory do
  it 'has a version number' do
    expect(Dory::VERSION).not_to be_nil
  end

  it 'has a date' do
    expect(Dory::DATE).not_to be_nil
  end
end
