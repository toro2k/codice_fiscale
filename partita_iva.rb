# http://www.icosaedro.it/cf-pi/
#
# http://it.wikipedia.org/wiki/Partita_IVA
#
# DA VERIFICARE!!!
class PartitaIva

  def self.valid?(string)
    string =~ /\A[0-9]{11}\Z/ or return false

    *payload, control = string.each_char.map(&:to_i)
    sum = payload.each_with_index.reduce(0) do |sum, (digit, index)|
      if index.even?
        sum + digit
      else
        add = digit * 2
        add -= 9 if add > 9
        sum + add
      end
    end

	  rest = sum % 10
	  checksum = rest.zero? ? 0 : 10 - rest
	  return checksum == control
  end

end
