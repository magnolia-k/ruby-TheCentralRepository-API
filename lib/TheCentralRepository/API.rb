require "TheCentralRepository/API/version"

require "open-uri"
require "JSON"

module TheCentralRepository

  class RequestParams
    def initialize(args)
      @spell_check = args["spellcheck"]
      @field_list = args["fl"].split(",")
      @sort = args["sort"].split(",")
      @indent = args["indent"]
      @query = args["q"]
      @query_field = args["qf"]
      @spell_check_count = args["spellcheck.count"]
      @writer_resolution = args["wt"]
      @rows = args["rows"]
      @version = args["version"]
      @default_type = args["defType"]
      @core = args["core"]
    end

    attr_reader :spell_check, :field_list, :sort, :indent, :query, :query_field,:spell_check_count, :writer_resolution, :rows, :version, :default_type, :core
  end

  class Artifact
    def initialize(args)
      @id = args["id"]                         # id
      @groupID = args["g"]                     # group ID
      @artifactID = args["a"]                  # arifact ID
      @latest_version = args["latestVersion"]  # latest version
      @packaging = args["p"]                   # packaging
      @extension_collection = args["ec"]       # extension collection?
      @repositoryID = args["repositoryId"]     # repository ID i.e. central
      @text = args["text"]                     # ???
      @time_stamp = args["timestamp"]          # time stamp
      @version_count = args["versionCount"]    # counter for number of versions
    end

    attr_reader :id, :groupID, :artifactID, :latest_version, :packaging, :extension_collection, :repositoryID, :text, :time_stamp, :version_count

  end

  class ArtifactVersion
    def initialize(args)
      @id = args["id"]                   # id
      @groupID = args["g"]               # group ID
      @artifactID = args["a"]            # artifact ID
      @version = args["v"]               # version number
      @packaging = args["p"]             # packaging
      @extension_collection = args["ec"] # extension collection
      @time_stamp = args["timestamp"]    # time stamp
      @tags = args["tags"]               # tags
    end

    attr_reader :id, :groupID, :artifactID, :version, :packaging, :extension_collection, :time_stamp, :tags
  end

  module API

    @@base_url = "http://search.maven.org/solrsearch/select?"

    def self.retreave_artifact(query)
      open(query) { |f|
        res = JSON.parse(f.read)

        if res["response"]["numFound"] == 0 then
          raise "Could not fetch..."
        end

        return {
          :artifacts => res["response"]["docs"].map { |item|
            Artifact.new(item)
          },

          :number_of_found => res["response"]["numFound"],
          :start => res["response"]["start"],

          :request_params => RequestParams.new(res["responseHeader"]["params"])
        }
      }
    end
   
    def self.retreave_artifact_version(query)
      open(query) { |f|
        res = JSON.parse(f.read)

        if res["response"]["numFound"] == 0 then
          raise "Could not fetch..."
        end

        return {
          :artifact_versions => res["response"]["docs"].map { |item|
            ArtifactVersion.new(item)
          },

          :number_of_found => res["response"]["numFound"],
          :start => res["response"]["start"],

          :request_params => RequestParams.new(res["responseHeader"]["params"])
        }
      }
    end

    def self.search_by_keyword(keyword, start = 0, rows = 20)
      query = @@base_url + "q=#{keyword}&start=#{start}&rows=#{rows}&wt=json"

      result = retreave_artifact(query)

      return result
    end

    def self.search_by_coodinate(coodinate, start = 0, rows = 20)

      params = Array.new
      keys = {
        :groupID => "g",
        :artifactID => "a",
        :version => "v",
        :packaging => "p",
        :classifier => "l"
      }

      keys.select { |k, v|
        if coodinate.has_key?(k) then
          params.push(%!#{keys[v]}:"#{coodinate[k]}"!)
        end
      }

      query = @@base_url + "q=" + params.join("%20AND%20") +
        "&start=#{start}&rows=#{rows}&wt=json"

      result = retreave_artifact(query)

      return result
    end

    def self.search_by_classname(classname, start = 0, rows = 20)
      query = @@base_url + %!q=c:"#{classname}"&start=#{start}&rows=#{rows}&wt=json!

      result = retreave_artifact(query)

      return result
    end

    def self.search_by_fully_qualified_classname(fully_qualified_classname, start = 0, rows = 20)
      query = @@base_url + %!q=fc:"#{fully_qualified_classname}"&start=#{start}&rows=#{rows}&wt=json!

      result = retreave_artifact(query)

      return result
    end

    def self.search_by_SHA1(sha1, start = 0, rows = 20)
      query = @@base_url + %!q=1:"#{sha1}"&start=#{start}&rows=#{rows}&wt=json!

      result = retreave_artifact(query)

      return result
    end

    def self.search_by_tag(tag, start = 0, rows = 20)
      query = @@base_url + "q=tags:#{tags}&start=#{start}&rows=#{rows}&wt=json"

      result = retreave_artifact(query)

      return result
    end

    def self.create_link_for_download(groupID, artifactID, version, extension)
      path = "http://search.maven.org/remotecontent?filepath=" +
        groupID.gsub(/\./, "/") +
        "/#{artifactID}/#{version}/#{artifactID}-#{version}.extension"

      return path
    end

    def self.collect_artifact_versions(groupID, artifactID, ver_re = nil, start = 0, rows = 20)

      query = @@base_url + %!q=g:"#{groupID}"+AND+a:"#{artifactID}"&core=gav&start=#{start}&rows=#{rows}&wt=json!

      result = retreave_artifact_version(query)

      if ver_re then
        result[:artifact_versions] = result[:artifact_versions].grep(ver_re)
      end

      return result
    end

  end
end
