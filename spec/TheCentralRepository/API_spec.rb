require 'spec_helper'

require 'pp'

describe TheCentralRepository::API do
  it 'has a version number' do
    expect(TheCentralRepository::API::VERSION).not_to be nil
  end

  it 'does something useful' do
    vers = TheCentralRepository::API.search_by_keyword("specs2")
    pp vers[:artifacts][0]
    pp vers[:request_params].version
    pp vers[:number_of_found]
    expect(true).to eq(true)
  end

  it 'does something useful' do
    vers = TheCentralRepository::API.collect_artifact_versions("org.specs2", "specs2-core_2.11")
    pp vers[:artifact_versions][0]
    pp vers[:request_params].version
    pp vers[:number_of_found]

  end

end
