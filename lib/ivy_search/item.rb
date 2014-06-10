module IvySearch
  ATTRIBUTE_KEYS = [:id, :title, :artist, :genres]

  class Item
    def initialize(args = nil)
      if args.is_a?(Hash)
        @attributes = args.inject({}) do |attrs, key, value|
          attrs[key] = value if ATTRIBUTE_KEYS.include?(key)
          attrs
        end
      else
        @attributes = {}
      end
    end
  end
end
