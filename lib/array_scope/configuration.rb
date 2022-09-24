class Configuration
  attr_accessor :define_method, :define_scope

  def initialize
    @define_method = false
    @define_scope = false
  end
end
