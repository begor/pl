class Hello
  def first_method
    puts "Hello, world"
  end
end

h = Hello.new
h.first_method

class B
  def m1
    42
  end

  def m2 x
    x.abs + 2 * self.m1
  end
end

# Instance and Class state

class C
  Foo = "bar" # Class constant, don't mutate it

  def initialize # Initializer
    @foo = 0  # Instance's variable; private
    @@bar = 0 # Class's variable, shared between instances; private
  end

  def m1 x
    @foo += x   # Mutate @foo only for one concrete instace
    @@bar += 1  # Mutate @@bar across every instance of a class C
  end

  def foo # Kinda like accessor
    @foo
  end

  def bar
    @@bar
  end

end



  # Rational example

class MyRational

  def initialize(num, den=1)
    if den == 0
      raise "MyRational zero denominator"
    elsif den < 0
      @num = - num
      @den = - den
    else
      @num = num
      @den = den
    end
    reduce # Can't call self.reduce, because it's private
  end

  def to_s
    ans = @num.to_s
    if @den != 1
      ans += '/'
      ans += @den.to_s
    end
    ans
  end

  def add! r  # Mutate self in place
    a = r.num  # Works because of protected methods
    b = r.den
    c = @num
    d = @den
    @num = (a * d) + (b * c)
    @den = b * d
    reduce
    self  # Allow for message chaining
  end

  def + r  # Functional, immutable addition; sytactic sugar: can write r1 + r2
    ans = MyRational.new(@num, @den)  # Clone self
    ans.add! r
  end

  protected
  # Can also do it with attr_reader :num, :den
  def num
    @num
  end

  def den
    @den
  end

  private

  def gcd(x, y)
    if x == y
      x
    elsif x < y
      gcd(x, y-x)
    else
      gcd(y, x)
    end
  end

  def reduce
    if @num == 0
      @den = 1
    else
      d = gcd(@num.abs, @den)
      @num = @num / d
      @den = @den / d
    end
  end
end

# top-level method (belongs to Object class)
def use_rationals
  r1 = MyRational.new(3, 4)
  r2 = r1 + r1 + MyRational.new(-5, 2) # syntactic sugar for (r1.+(r1)).+(MyRational.new(...))
  puts r2.to_s
  (r2.add! r1).add! (MyRational.new(1, -4))
  puts r2.to_s
end


# Dynamic classes
class MyRational
  def double  # Now available in every MyRational instance, even intanciated earlier
    self + self
  end
end


# Blocks

class Foo
  def initialize(max)
    @max = max
  end

  def silly
    yield(4, 5) + yield(@max, @max)
  end

  # Takes block.
  # Counts how many times you should go from base to max until block yields true
  def count base
    if base > @max
      raise "max reached"
    elsif yield base  # If block returns true we are done
      1
    else
      1 + (count(base+1) {|i| yield i})  # Recursively call WITH THE SAME BLOCK as given
    end
  end
end
