module NytEventListings
  class Event
    def initialize(options)
      @fields = options
    end

    def respond_to?(name)
      if @fields.keys.include?(name.to_s)
        true
      else
        super
      end
    end

    def method_missing(name, *args)
      if respond_to?(name)
        @fields[name.to_s]
      else
        super
      end
    end
  end
end
