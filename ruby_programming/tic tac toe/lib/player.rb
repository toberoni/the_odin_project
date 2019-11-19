class Player
  attr_accessor :sign, :name

  def initialize(args)
    @name = args[:name]
    @sign = args[:sign]
  end

end