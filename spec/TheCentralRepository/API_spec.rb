require 'spec_helper'

require 'pp'

describe TheCentralRepository::API do
  it 'has a version number' do
    expect(TheCentralRepository::API::VERSION).not_to be nil
  end

  it 'search by keyword' do
    result = TheCentralRepository::API.search_by_keyword("scala-dist")
    expect(result[:artifacts].length).to be > 0
  end

  it "collect artifact's version" do
    vers1 = TheCentralRepository::API.collect_artifact_versions("org.scala-lang", "scala-dist")

    vers2 = TheCentralRepository::API.collect_artifact_versions("org.scala-lang", "scala-dist", /^\d\.\d+\.\d+$/)

    expect(vers1[:artifact_versions].length).to be > vers2[:artifact_versions].length
  end

end
