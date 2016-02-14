load 'point.rb'
#require 'point'
class Map
  def initialize
    set_size
    set_step
    set_map

    start = Point.new(0,0)
    start.weight = 0
    start.in_work = false
    build_weighted_graph(start)

    show_map
    @result = []
    @result << @points[-1]
    @points.each{ |i| i.in_work = true }

    @result[0].in_work = false
    build_answer(@result[0])

    @result.each { |i| puts "point answer  x = #{i.x} y = #{i.y} " }
  end

  def set_size
    puts 'Enter size map:'
    @size = gets().to_i
  end

  def set_step
    puts 'Enter max step'
    @step = gets.to_f
  end

  def set_map
    @points = []
    @size.times do []
    puts 'enter x and y in on one line:'
    arr = gets.to_s.split
    @points << Point.new(arr[0].to_f, arr[1].to_f)
    end
    @points << Point.new(@size.to_f, @size.to_f)
  end


  def get_list_point(cur_point)
    result = []
    @points.each do |iter|
      tmp = iter.distance(cur_point)
      if (tmp < @step) and tmp!=0 and iter.in_work
        result << @points.index(iter)
      end
    end
    return result
  end

  def build_weighted_graph(cur_point)
    neighbors = get_list_point(cur_point)

    if !neighbors.empty?

      neighbors.each do |index|
        point = @points[index]
        distance = point.distance(cur_point)
        tmp = cur_point.weight + distance
        if point.weight == -1
          point.weight = tmp
        elsif point.weight > tmp
          point.weight = tmp
        end
      end
      cur_point.in_work = false
      number = -1
      tmp = -1
      neighbors.each do |i|
        if tmp > @points[i].weight or tmp == -1
          number = i
          tmp = @points[i].weight
        end
      end
      build_weighted_graph(@points[number])
    end

  end

  def show_map
    @points.each { |i| puts "x= #{i.x} y= #{i.y}    #{i.weight}"}
  end

  def build_answer(cur_point)
    neighbors = get_list_point(cur_point)
    pos = -1
    if !neighbors.empty?
      distance =0
      neighbors.each do |index|
        point = @points[index]
        # tmp = point.distance(cur_point)
        if(point.weight != -1 and point.weight < @result[-1].weight)
          tmp = cur_point.weight - point.weight
            if tmp > distance and tmp < @step
              distance = tmp
              pos = index
            end
          end
        end
      end
      @result << @points[pos]
      if pos != 0
        cur_point.in_work = false
        build_answer(@points[pos])
      end
    end
  end



Map.new