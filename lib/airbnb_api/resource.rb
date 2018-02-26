module AirbnbApi
  module Resource
    def initialize(attributes)
      self.attributes = attributes
    end

    def attributes=(attributes)
      @attributes = attributes
      attributes.each do |attribute, value|
        if respond_to?(writer = attribute.to_s + '=')
          send(writer, value)
        else
          # self.class.logger.warn "`#{attribute}' is not a listed attribute for #{self.class}"
        end
      end
    end

    module ClassMethods
      attr_reader :attributes

      def attributes(attributes)
        attr_accessor(*@attributes = attributes)
      end

      def build(attributes)
        new(attributes)
      end
    end
  end
end
