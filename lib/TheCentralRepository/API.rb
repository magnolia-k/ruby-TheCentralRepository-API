require "TheCentralRepository/API/version"

require "uri"
require "open-uri"
require "JSON"

module TheCentralRepository
  module API
    def self.search(groupID, artifactID, ver_re = nil)
      url = "http://search.maven.org/solrsearch/select?"
      param = %!q=g:"#{groupID}"+AND+a:"#{artifactID}"&core=gav&rows=40&wt=json!
      
      begin
        open(url + param) { |f|
          res = JSON.parse(f.read)

          if (res["response"]["numFound"] == 0)
            raise "Can't get target"
          else
            vers = res["response"]["docs"].map { |item| item["v"] }
            if (ver_re == nil)
              return vers
            else
              return vers.grep(ver_re)
            end
          end
        }

      rescue SocketError
        puts "SocketError:#{url + param}"
        exit

      rescue OpenURI::HTTPError
        puts "OpenURI::HTTPError:#{url + param}"
        exit
      end
    end
  end
end
