# http://www.icosaedro.it/cf-pi/
#
# http://it.wikipedia.org/wiki/Partita_IVA
#
# DA VERIFICARE!!!
class PartitaIva

  def initialize(string)
    fail ArgumentError.new(string) unless string =~ /\A[0-9]{11}\Z/
    *@payload, @control = string.each_char.map(&:to_i)
  end

  def valid?
    checksum == @control
  end

  def checksum
    sum = @payload.each_with_index.reduce(0) do |sum, c|
      digit, index = c
      if index.even?
        sum += digit
      else
        add = digit * 2
        add -= 9 while add > 9
        sum += add
      end
      next sum
    end
    rest = sum % 10
    return rest.zero? ? 0 : 10 - rest
  end

  def to_s
    "<PI #{@payload.join('')}#{@control}>"
  end

end
