module AirbnbApi
  module Resource
    def initialize(attributes)
      self.attributes = self.class.root_element ? attributes.dig(self.class.root_element) : attributes
    end

    private

    def attributes=(attributes)
      @attributes = attributes

      attributes.each do |attribute, value|
        if self.class.many && self.class.many.has_key?(attribute.to_sym)
          items = value.map do |data|
            self.class.many[attribute.to_sym].new(data)
          end
          send(attribute.to_s + '=', items)
        elsif respond_to?(writer = attribute.to_s + '=')
          send(writer, value)
        else
          # self.class.logger.warn "`#{attribute}' is not a listed attribute for #{self.class}"
        end
      end
    end

    module ClassMethods

      attr_reader :attributes, :many, :root

      def has_attributes(attributes)
        attr_accessor(*@attributes = attributes)
      end

      def has_many(attribute, klass)
        @many ||= {}
        @many[attribute.to_sym] = klass
        attr_accessor(attribute.to_sym)
      end

      def has_root(boolean)
        @root = boolean
      end

      def root_element
        @root = @root.nil? ? true : @root
        @root ? name.to_s.gsub(/([^\^])([A-Z])/,'\1_\2').downcase.to_sym : nil
      end

      def build(attributes)
        new(attributes)
      end
    end
  end
end
