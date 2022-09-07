# frozen_string_literal: true

require_relative "array_scope/version"

module ArrayScope
  class Error < StandardError; end

  def array_scope(method_name, body)
    array_scope_method_name = -> (cn, mn) { "#{class_name_key(cn)}_#{mn}".to_sym }

    define_method_name = array_scope_method_name[self.name, method_name]

    Array.class_exec do
      define_method(define_method_name, &body)

      private define_method_name

      define_method(method_name) do |*args|
        raise NoMethodError, "undefined method `#{method_name}' for #{self.inspect}:Array" if size.zero?

        classes = map { |obj| obj.class }.uniq
        raise NoMethodError, "undefined method `#{method_name}' for #{self.inspect}:Array" unless classes.size == 1

        send(array_scope_method_name[classes.first.name, method_name], *args)
      end
    end
  end

  def class_name_key(string)
    string
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr("::", "__")
      .downcase
  end

  private_methods :class_name_key
end
