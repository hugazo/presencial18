# Ejercicio 1 Desafio Latam

class Table
  attr_reader :name, :earnings
  def initialize(name, *earnings)
    @name = name
    @earnings = earnings.map(&:to_i)
  end

  def to_s
    ganancias = @earnings.inject('') { |ret, x| ret + "#{x} " }
    "#{@name}, Ganancias: #{ganancias}"
  end

  def encontrar_mejor_dia
    "Mejor Recaudación -#{@name}-
Dia: #{mejor_dia[:day] + 1}, Valor: #{mejor_dia[:value]}"
  end

  def mejor_dia
    value = @earnings.max
    day = @earnings.index(value)
    { day: day, value: value }
  end

  def encontrar_promedio_ganancia
    "El promedio de ganancia para #{@name} es de #{promedio_ganancia}"
  end

  def promedio_ganancia
    total_ganancia / @earnings.length.to_f
  end

  def total_ganancia
    @earnings.inject(0) { |sum, x| sum + x }
  end
end

def leer_archivo(file)
  tables = []
  data = []
  File.open(file, 'r') { |info| data = info.readlines }
  data.each do |prod|
    ls = prod.split(', ')
    tables << Table.new(*ls)
  end
  tables
end

def best_value(tables)
  best_earning = { value: 0, day: nil }
  table = ''
  tables.each do |x|
    if x.mejor_dia[:value] > best_earning[:value]
      best_earning = x.mejor_dia
      table = x.name
    end
  end
  "Mejor ganancia: #{table}
Día #{best_earning[:day] + 1}, con total de #{best_earning[:value]}"
end

def average_earning(tables)
  av = tables.inject(0) { |sum, x| sum + x.promedio_ganancia } / tables.length
  "El promedio de ganancia de las mesas por día es de #{av}"
end

tables = leer_archivo('casino.txt')
tables.each { |x| puts x }
puts best_value(tables)
puts average_earning(tables)
