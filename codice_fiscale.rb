# http://www.icosaedro.it/cf-pi/
#
# http://www.agenziaentrate.gov.it/wps/content/Nsilib
#   /Nsi/Home/CosaDeviFare/Richiedere/Codice+fiscale+e+tessera+sanitaria
#     /Richiesta+TS_CF/SchedaI/Informazioni+codificazione+pf/
class CodiceFiscale

  LETTERS = Hash[('A'..'Z').each_with_index.to_a].freeze
  DIGITS = Hash[('0'..'9').each_with_index.to_a].freeze
  CF_TABLE = {
    :even => {
      '0' =>  1, '1' =>  0, '2' =>  5, '3' =>  7, '4' =>  9, '5' => 13,
      '6' => 15, '7' => 17, '8' => 19, '9' => 21, 'A' =>  1, 'B' =>  0,
      'C' =>  5, 'D' =>  7, 'E' =>  9, 'F' => 13, 'G' => 15, 'H' => 17,
      'I' => 19, 'J' => 21, 'K' =>  2, 'L' =>  4, 'M' => 18, 'N' => 20,
      'O' => 11, 'P' =>  3, 'Q' =>  6, 'R' =>  8, 'S' => 12, 'T' => 14,
      'U' => 16, 'V' => 10, 'W' => 22, 'X' => 25, 'Y' => 24, 'Z' => 23
    },
    :odd => LETTERS.merge(DIGITS)
  }.freeze

  def self.valid?(string)
    string.upcase! rescue return false
    string =~ /\A[A-Z0-9]{16}\z/ or return false

    *payload, control = string.each_char.to_a
    sum = payload.each_with_index.reduce(0) do |sum, (char, index)|
      if index.even?
        sum + CF_TABLE[:even][char]
      else
        sum + CF_TABLE[:odd][char]
      end
    end

    return LETTERS.key(sum % 26) == control
  end

end
