class Frac
  attr_reader :numerator
  attr_reader :denominator
  public
  def initialize(numerator, denominator)
    @numerator, @denominator = reduce(numerator, denominator)
  end

  def to_s
    "#{@numerator}/#{@denominator}"
  end

  def +(another)
    a = self.numerator*another.denominator + self.denominator*another.numerator
    b = self.denominator*another.denominator
    Frac.new(a, b)
  end

  def -(another)
    a = self.numerator*another.denominator - self.denominator*another.numerator
    b = self.denominator*another.denominator
    Frac.new(a, b)
  end

  def *(another)
    a = self.numerator*another.numerator
    b = self.denominator*another.denominator
    Frac.new(a, b)
  end

  def /(another)
    a = self.numerator*another.denominator
    b = self.denominator*another.numerator
    Frac.new(a, b)
  end

  def <=>
    self.numerator*another.denominator <=> self.denominator*another.numerator
  end

  def ==
    self.numerator*another.denominator == self.denominator*another.numerator
  end

  def to_i
    (@numerator/@denominator).to_i
  end

  def to_f
    (@numerator/@denominator).to_f
  end

  def number
    n =1
    i = 1; j =1
    while !(i == @numerator && j ==@denominator)
      if i%2 != 0 && j == 1
        i+=1;
      elsif i==1 && j%2 ==0
        j+=1
      elsif (i+j)%2 != 0
        i-=1 ; j+=1
      else
        i+=1; j-=1;
      end
      n+=1
    end
    return n
  end




  private
  def evcl(a,b)
    if a > b
      helper_evcl(a, b)
    else
      helper_evcl(b, a)
    end
  end

  def helper_evcl(a, b)
    return a if b == 0
    helper_evcl(b, a % b)
  end

  def reduce(a, b)
    tmp = evcl(a,b)
    a1 = a/tmp ; b1 = b/tmp
    return a1,b1
  end
end

x = Frac.new(1, 3)
y = Frac.new(462, 1071)

puts (x+y).to_s
puts (x-y).to_s
puts (x*y).to_s
puts (x/y).to_s

puts (x.to_i)
puts x.number