require_relative 'array_scope'

class Hoge
  extend ArrayScope

  array_scope :==, -> { 'a' }
end

# [Hoge.new].==