module Population
  def self.included(klass)
    klass.class_eval do
      @population = 0

      def self.inherited(base)
        base.class_eval do
          @population = 0
        end
      end

      extend ClassMethods
      prepend Initializer
    end
  end

  module Initializer
    def initialize(*args)
      self.class.ancestors.each do |klass|
        if klass.respond_to?(:record_new_instance, true)
          klass.send(:record_new_instance)
        end
      end
      super
    end
  end

  module ClassMethods
    attr_reader :population

    private
    def record_new_instance
      @population += 1
    end
  end
end
