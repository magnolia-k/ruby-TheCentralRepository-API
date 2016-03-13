require 'spec_helper'

describe TheCentralRepository::API do
  it 'has a version number' do
    expect(TheCentralRepository::API::VERSION).not_to be nil
  end

  it 'search by keyword' do
    result = TheCentralRepository::API.search_by_keyword("scala-dist")
    expect(result[:artifacts].length).to be > 0
  end

  it 'search by coodinate' do
    coodinate = { :groupID => "org.scala-lang" }
    result = TheCentralRepository::API.search_by_coodinate( coodinate )
    expect(result[:artifacts].length).to be > 0
  end

  it 'search by classname' do
    result = TheCentralRepository::API.search_by_classname("junit")
    expect(result[:artifacts].length).to be > 0
  end

  it 'search by qualified classname' do
    result = TheCentralRepository::API.search_by_fully_qualified_classname("org.specs.runner.JUnit")
    expect(result[:artifacts].length).to be > 0
  end

  it 'search by SHA1' do
    result = TheCentralRepository::API.search_by_SHA1("40f7f4453fa7b6b9188fabb34d0771d0ca15da2f")
    expect(result[:artifacts].length).to be > 0
  end

  it 'search by tags' do
    result = TheCentralRepository::API.search_by_tags("sbtplugin")
    expect(result[:artifacts].length).to be > 0
  end

  it "collect artifact's version" do
    vers1 = TheCentralRepository::API.collect_artifact_versions("org.scala-lang", "scala-dist")

    vers2 = TheCentralRepository::API.collect_artifact_versions("org.scala-lang", "scala-dist", /^\d\.\d+\.\d+$/)

    expect(vers1[:artifact_versions].length).to be > vers2[:artifact_versions].length
  end

end
