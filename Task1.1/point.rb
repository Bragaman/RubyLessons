class Point

  attr_accessor :x
  attr_accessor :y
  attr_accessor :weight
  attr_accessor :in_work
  def initialize(x, y)
    @x = x
    @y = y
    @weight = -1
    @in_work = true
  end

  def distance(point)
    ((@x-point.x)**2 + (@y-point.y)**2)**0.5
  end
end