require 'date'
# TODO: Debo hacer los handler de fechas >= a 2018-01-01

class Course
  attr_reader :name, :start, :finish
  def initialize(name, start, finish)
    @name = name
    @start = Date.parse(start)
    @finish = Date.parse(finish)
  end

  def to_h
    { name: @name, start: @start, finish: @finish }
  end

  def to_s
    "#{@name} #{@start} #{@finish} "
  end

  def begins_prior_to(date = Date.today.to_s)
    if date_2018(date)
      raise ArgumentError, 'Argument must not be year 2018 or above'
    end
    Date.parse(date) > @start
  end

  def ends_after_to(date = Date.today.to_s)
    if date_2018(date)
      raise ArgumentError, 'Argument must not be year 2018 or above'
    end
    Date.parse(date) < @finish
  end

  private def date_2018(date)
    Date.parse(date) >= Date.parse('2018-01-01')
  end
end

def leer_archivo(file)
  courses = []
  data = []
  File.open(file, 'r') { |info| data = info.readlines }
  data.each do |prod|
    ls = prod.split(', ')
    courses << Course.new(*ls)
  end
  courses
end

def course_begins_prior_to(cursos, date)
  res = []
  cursos.each { |x| res.push x if x.begins_prior_to(date) }
  res
end

def course_ends_after_to(cursos, date)
  res = []
  cursos.each { |x| res.push x if x.ends_after_to(date) }
  res
end

cursos = leer_archivo('cursos.txt')
date = '2017-05-20'
puts "Cursos que comienzan antes de #{date}"
puts course_begins_prior_to(cursos, date)
puts "Cursos que finalizan despues de #{date}"
puts course_ends_after_to(cursos, date)
puts course_begins_prior_to(cursos, '2018-01-01')
