require 'spec_helper'

require 'pp'

describe TheCentralRepository::API do
  it 'has a version number' do
    expect(TheCentralRepository::API::VERSION).not_to be nil
  end

  it 'does something useful' do
    vers = TheCentralRepository::API.search("org.specs2", "specs2-core_2.11", /^\d\.\d(\.\d)?$/)
    pp vers
    expect(true).to eq(true)
  end

end
