class Cell
  attr_accessor :state, :index, :kind

  def initialize(index=0)
    @state = '[▓]'
    @index = index
    @kind =  ''
  end

  def die
    @state = '[▓]'
  end

  def live
    @state = '[▒]'
  end

  def is_alive?
    return true if @state == '[▒]'
    return false if @state != '[▒]'
  end
end
