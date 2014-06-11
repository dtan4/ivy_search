require "nokogiri"
require "open-uri"

module IvySearch
  module HttpUtil
    def fetch_web_page(url)
      raise ArgumentError unless url

      begin
        Nokogiri::HTML.parse(open(url).read)
      rescue
        raise HttpError
      end
    end
  end

  class HttpError < RuntimeError; end
end
