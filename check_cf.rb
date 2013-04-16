module Cf

	LETTERS = Hash[('A'..'Z').each_with_index.to_a].freeze
	DIGITS = Hash[('0'..'9').each_with_index.to_a].freeze
	CF_TABLE = {
		:even => {
			'0' => 1,
			'1' => 0,
			'2' => 5,
			'3' => 7,
			'4' => 9,
			'5' => 13,
			'6' => 15,
			'7' => 17,
			'8' => 19,
			'9' => 21,
			'A' => 1,
			'B' => 0,
			'C' => 5,
			'D' => 7,
			'E' => 9,
			'F' => 13,
			'G' => 15,
			'H' => 17,
			'I' => 19,
			'J' => 21,
			'K' => 2,
			'L' => 4,
			'M' => 18,
			'N' => 20,
			'O' => 11,
			'P' => 3,
			'Q' => 6,
			'R' => 8,
			'S' => 12,
			'T' => 14,
			'U' => 16,
			'V' => 10,
			'W' => 22,
			'X' => 25,
			'Y' => 24,
			'Z' => 23
		},
		:odd => LETTERS.merge(DIGITS)
	}.freeze

	def self.cf?(string)
		string.upcase!

		return false unless string =~ /\A[A-Z0-9]{16}\Z/

		*payload, control = string.each_char.to_a

		sum = payload.each_with_index.reduce(0) do |sum, c|
			char, index = c
			if index.even?
				sum += CF_TABLE[:even][char]
			else
				sum += CF_TABLE[:odd][char]
			end
			next sum
		end

		return LETTERS.rassoc(sum % 26)[0] == control
	end

	def self.pi?(string)
		return false unless string =~ /\A[0-9]{11}\Z/

		*payload, control = string.each_char.map(&:to_i)

		sum = payload.each_with_index.reduce(0) do |sum, c|
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

		rest = if sum % 10 == 0
			       0
		       else
			       10 - (sum % 10)
		       end

		return control == rest
	end

end

puts Cf.cf?('trlndr82s12d969g')
puts Cf.cf?('CZZPIO04B04B320w')

puts Cf.pi?('06013061004')
puts Cf.pi?('04856801008')

puts Cf.cf?('grdntn42s12d969a')
puts Cf.pi?('06034373474')
