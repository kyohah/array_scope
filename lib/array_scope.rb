# frozen_string_literal: true

require_relative "array_scope/version"
require_relative 'array_scope/configuration'

class ArrayScope
  class Error < StandardError; end

  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  module Classes; end

  attr_accessor :array

  def initilize(objects)
    array = objects
  end

  def method_missing
    super if array.size.zero?

    classes = array.map { |obj| obj.class }.uniq

    super unless classes.size == 1

    begin
      klass = Object.const_get("ArrayScope::Classes::#{classes.first.name}")
    rescue NameError
      super
    end

    if klass.method_defined?(name)
      klass.new.send(name, *args)
    else
      super
    end
  end

  def array_scope(method_name, body)

    begin
      klass = Object.const_get("ArrayScope::Classes::#{self.name}")
    rescue NameError
      klass = ArrayScope::Classes.const_set self.name, Class.new
    end

    klass.class_exec do
      define_method(method_name, &body)
    end

    if ArrayScope.configuration.define_method
      Array.class_exec do
        def method_missing(name, *args)
          super if size.zero?

          classes = map { |obj| obj.class }.uniq

          super unless classes.size == 1

          begin
            klass = Object.const_get("ArrayScope::Classes::#{classes.first.name}")
          rescue NameError
            super
          end

          if klass.method_defined?(name)
            klass.new.send(name, *args)
          else
            super
          end
        end
      end
    end

    if ArrayScope.configuration.define_scope
      Array.class_exec do
        define_method(:scope) do |method_name, args = {}|
          raise ArrayScope::Error if size.zero?

          classes = map { |obj| obj.class }.uniq

          raise ArrayScope::Error unless classes.size == 1

          begin
            klass = Object.const_get("ArrayScope::Classes::#{classes.first.name}")
          rescue NameError
            super
          end

          if klass.method_defined?(method_name)
            klass.new.send(method_name, *args)
          else
            raise ArrayScope::Error
          end
        end
      end
    end
  end
end
