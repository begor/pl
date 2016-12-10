# Note: If Exp and Value are empty classes, we do not need them in a
# dynamically typed language, but they help show the structure and they
# can be useful places for code that applies to multiple subclasses.

class Exp
  # could put default implementations or helper methods here
end

class Int < Value
  attr_reader :i
  def initialize i
    @i = i
  end
  def eval # no argument because no environment
    self
  end
  def toString
    @i.to_s
  end
  def hasZero
    i==0
  end
  def noNegConstants
    if i < 0
      Negate.new(Int.new(-i))
    else
      self
    end
  end
  # double-dispatch for adding values
  def add_values v # first dispatch
    v.addInt self
  end
  def addInt v # second dispatch: other is Int
    Int.new(v.i + i)
  end
  def addString v # second dispatch: other is MyString (notice order flipped)
    MyString.new(v.s + i.to_s)
  end
  def addRational v # second dispatch: other is MyRational
    MyRational.new(v.i+v.j*i,v.j)
  end
end

# new value classes -- avoiding name-conflict with built-in String, Rational
class MyString < Value
  attr_reader :s
  def initialize s
    @s = s
  end
  def eval
    self
  end
  def toString
    s
  end
  def hasZero
    false
  end
  def noNegConstants
    self
  end

  # double-dispatch for adding values
  def add_values v # first dispatch
    v.addString self
  end
  def addInt v # second dispatch: other is Int (notice order is flipped)
    MyString.new(v.i.to_s + s)
  end
  def addString v # second dispatch: other is MyString (notice order flipped)
    MyString.new(v.s + s)
  end
  def addRational v # second dispatch: other is MyRational (notice order flipped)
    MyString.new(v.i.to_s + "/" + v.j.to_s + s)
  end
end

class MyRational < Value
  attr_reader :i, :j
  def initialize(i,j)
    @i = i
    @j = j
  end
  def eval
    self
  end
  def toString
    i.to_s + "/" + j.to_s
  end
  def hasZero
    i==0
  end
  def noNegConstants
    if i < 0 && j < 0
      MyRational.new(-i,-j)
    elsif j < 0
      Negate.new(MyRational.new(i,-j))
    elsif i < 0
      Negate.new(MyRational.new(-i,j))
    else
      self
    end
  end

  # double-dispatch for adding values
  def add_values v # first dispatch
    v.addRational self
  end
  def addInt v # second dispatch
    v.addRational self  # reuse computation of commutative operation
  end
  def addString v # second dispatch: other is MyString (notice order flipped)
    MyString.new(v.s + i.to_s + "/" + j.to_s)
  end
  def addRational v # second dispatch: other is MyRational (notice order flipped)
    a,b,c,d = i,j,v.i,v.j
    MyRational.new(a*d+b*c,b*d)
  end
end

class Negate < Exp
  attr_reader :e
  def initialize e
    @e = e
  end
  def eval
    Int.new(-e.eval.i) # error if e.eval has no i method
  end
  def toString
    "-(" + e.toString + ")"
  end
  def hasZero
    e.hasZero
  end
  def noNegConstants
    Negate.new(e.noNegConstants)
  end
end

class Add < Exp
  attr_reader :e1, :e2
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end
  def eval
    e1.eval.add_values e2.eval
  end
  def toString
    "(" + e1.toString + " + " + e2.toString + ")"
  end
  def hasZero
    e1.hasZero || e2.hasZero
  end
  def noNegConstants
    Add.new(e1.noNegConstants,e2.noNegConstants)
  end
end

class Mult < Exp
  attr_reader :e1, :e2
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end
  def eval
    Int.new(e1.eval.i * e2.eval.i) # error if e1.eval or e2.eval has no i method
  end
  def toString
    "(" + e1.toString + " * " + e2.toString + ")"
  end
  def hasZero
    e1.hasZero || e2.hasZero
  end
  def noNegConstants
    Mult.new(e1.noNegConstants,e2.noNegConstants)
  end
end


# Mixins


module Doubler
  def double
    self + self # uses self's + message, not defined in Doubler
  end
end

class Pt
  attr_accessor :x, :y
  include Doubler
  def + other
    ans = Pt.new
    ans.x = self.x + other.x
    ans.y = self.y + other.y
    ans
  end
end

class String
  include Doubler
end

# these are probably the two most common uses in the Ruby library:
#  Comparable and Enumerable

# you define <=> and you get ==, >, <, >=, <= from the mixin
# (overrides Object's ==, adds the others)
class Name
  attr_accessor :first, :middle, :last
  include Comparable
  def initialize(first,last,middle="")
    @first = first
    @last = last
    @middle = middle
  end
  def <=> other
    l = @last <=> other.last # <=> defined on strings
    return l if l != 0
    f = @first <=> other.first
    return f if f != 0
    @middle <=> other.middle
  end
end

# Note ranges are built in and very common
# you define each and you get map, any?, etc.
# (note map returns an array though)
class MyRange
  include Enumerable
  def initialize(low,high)
    @low = low
    @high = high
  end
  def each
    i=@low
    while i <= @high
      yield i
      i=i+1
    end
  end
end

# here is how module Enumerable could implement map:
# (but notice Enumerable's map returns an array,
#  *not* another instance of the class :( )
# def map
#   arr = []
#   each {|x| arr.push x }
#   arr
# end

# this is more questionable style because the mixin is using an
# instance variable that could clash with classes and has to be initialized
module Color
  def color
    @color
  end
  def color= c
    @color = c
  end
  def darken
    self.color = "dark " + self.color
  end
end

class Pt3D < Pt
  attr_accessor :z
  # rest of definition omitted (not so relevant)
end

class ColorPt < Pt
  include Color
end

class ColorPt3D < Pt3D
  include Color
end
