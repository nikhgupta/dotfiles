#!/usr/bin/env ruby

require 'pry'

class Timesheet
  include Comparable
  attr_reader :seconds

  def initialize(*obj)
    case
    when obj.length == 1 && obj[0].is_a?(Numeric)
      @seconds = obj[0].to_f
    when obj.length == 1 && obj[0].is_a?(String)
      s, m, h, d = obj[0].split(":", 4).reverse
      @seconds = d.to_f * 86400 + h.to_f * 3600 + m.to_f * 60 + s.to_f
    when obj.length == 2
      @seconds = obj[0].to_f * 60 + obj[1].to_f
    when obj.length == 3
      @seconds = obj[0].to_f * 3600 + obj[1].to_f * 60 + obj[2].to_f
    when obj.length == 4
      @seconds = obj[0].to_f * 86400 + obj[1].to_f * 3600 +  obj[2].to_f * 60 + obj[3].to_f
    else
      raise ArgumentError, "Can only parse numbers or strings"
    end
  end

  def inspect(days: nil)
    n = @seconds.abs.round
    d = (days.nil? && n > 99*3600 || days) ? n / 86400 : 0
    h = (n - d*86400)/3600
    m = (n - d*86400 - h*3600)/60
    s = n - d*86400 - h*3600 - m*60
    str = "#{'%02d' % m}:#{'%02d' % s}"
    str = "#{'%02d' % h}:#{str}" if h.positive? || d.positive?
    str = d.positive? ? "#{'%02d' % d}:#{str}" : str
    @seconds.negative? ? "-#{str}" : str
  end

  def hours
    @seconds/3600.0
  end

  def minutes
    @seconds/60.0
  end

  def days
    @seconds/86400.0
  end

  def +(other)
    self.class.new(@seconds + parse_seconds(other))
  end

  def -(other)
    self.class.new(@seconds - parse_seconds(other))
  end

  def *(num)
    raise TypeError, "must be a Numeric" unless num.is_a?(Numeric)
    self.class.new(@seconds * num)
  end

  def /(num)
    case
    when num.is_a?(Numeric) then self.class.new(@seconds / num)
    when num.is_a?(self.class) then @seconds / parse_seconds(num).to_f
    else raise TypeError, "must be Numeric or #{self.class}"
    end
  end

  def %(num)
    case
    when num.is_a?(Numeric) then @seconds % num
    when num.is_a?(self.class) then self.class.new(@seconds % parse_seconds(num))
    else raise TypeError, "must be Numeric or #{self.class}"
    end
  end

  def <=>(other)
    @seconds <=> parse_seconds(other)
  end

  def >=(other)
    @seconds >= parse_seconds(other)
  end

  def <=(other)
    @seconds <= parse_seconds(other)
  end

  def to_i
    @seconds
  end
  alias to_int to_i

  def round_to_minutes(m = 1)
    self.class.new((@seconds/(m*60.0)).round * 60 * m)
  end

  def round_to_hours(h = 1)
    self.class.new((@seconds/(h*3600.0)).round * 3600 * h)
  end

  def round_to_days(d = 1)
    self.class.new((@seconds/(d*86400.0)).round * 86400 * d)
  end

  def to_f
    @seconds.to_f
  end

  def to_s
    inspect
  end

  def to_hours_s
    inspect(days: false)
  end

  private

  def parse_seconds(obj)
    return obj.seconds if obj.is_a?(self.class)
    self.class.new(obj).seconds
  end
end

module Calculator
  def t(*obj); Timesheet.new(*obj); end
  def tp(str); str.gsub(/((?:\d*(?:\.\d*)?:*)*\d*(?:\.d*)?:*)/){|e| e.include?(":") ? "t('#{e}')" : e}; end
  def te(str); eval(tp(str)); end
end

include Calculator

# This is a simple calculator pry,
# with access to several conversions
# for easing out complex calculations.

binding.pry
