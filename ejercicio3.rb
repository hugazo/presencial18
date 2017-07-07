r = (1..10).to_a

# Clase ruleta.
class Roulette
  def initialize(numbers)
    @numbers = numbers
  end

  private def play(number)
    roulette_number = rand(0..@numbers.length - 1)
    resultado = { apostado: number,
                  ruleta: @numbers[roulette_number],
                  winner: number == roulette_number }
    resultado
  end

  def play_one_random_bet
    bet = play(rand(1..@numbers.length))
    save_bet(bet)
    bet
  end

  def play_one_bet(number)
    bet = play(number)
    save_bet(bet)
    bet
  end

  private def save_bet(bet)
    save_file('roullete_history.txt', bet)
    save_file('winners.txt', bet) if bet[:winner]
  end

  private def save_file(file, bet)
    File.open(file, 'a') { |x| x.puts bet[:ruleta] }
  end
end

def historic_winner(file)
  value, quantity = nil
  File.open(file, 'r') do |archivo|
    historic = archivo.readlines.map(&:to_i)
    commulative = historic.group_by(&:itself)
    resultado = commulative.transform_values(&:length).max_by { |_k, v| v }
    value = resultado[0]
    quantity = resultado[1]
  end
  { value: value, quantity: quantity }
end

ruleta = Roulette.new(r)
puts ruleta.play_one_random_bet
historic = historic_winner('roullete_history.txt')
print historic
