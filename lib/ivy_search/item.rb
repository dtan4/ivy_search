module IvySearch
  ATTRIBUTE_KEYS = [:id, :title, :artist, :genres]
  DOMAIN = "store.tsutaya.co.jp"

  class Item
    include HttpUtil

    def initialize(args = nil)
      if args.is_a?(Hash)
        @attributes = args.inject({}) do |attrs, (key, value)|
          attrs[key] = value if ATTRIBUTE_KEYS.include?(key)
          attrs
        end
      else
        @attributes = {}
      end
    end

    def id
      @attributes[:id]
    end

    def title
      @attributes[:title]
    end

    def artist
      @attributes[:artist]
    end

    def genres
      @attributes[:genres]
    end

    def check_stock(shop_id)
      raise ArgumentError unless shop_id

      body_doc = fetch_web_page(stock_check_url(shop_id))
      stock_status(body_doc)
    end

    private

    def stock_check_url(shop_id)
      "http://#{DOMAIN}/item/rental_cd/#{id}.html?storeId=#{shop_id}"
    end

    def stock_status(body_doc)
      {
       "○" => "o",
       "×" => "x",
       "－" => "-"
      }[stock_status_character(body_doc)]
    end

    def stock_status_character(body_doc)
      stock_status_element(body_doc).text.gsub(/［|］/, "")
    end

    def stock_status_element(body_doc)
      body_doc.css("div.myStoreBox").first.css("div.state span")
    end
  end
end
