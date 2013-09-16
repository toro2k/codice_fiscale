require 'test/unit'

require 'partita_iva'

class TestPartitaIva < MiniTest::Unit::TestCase

	def test_valid_partita_iva
		pis = ['0' * 11,
		       '4' * 10 + '0',
		       '12345678903']
		pis.each do |pi|
				assert(PartitaIva.valid?(pi),
				       "Expected #{pi} to be valid.")
		end
	end

	def test_invalid_partita_iva
		pis = ['1' * 11,
		       '0' * 10,
		       'A' * 11,
		       '',
		       ' ']

		pis.each do |pi|
			assert(!PartitaIva.valid?(pi),
			       "Expected #{pi} to be NOT valid.")
		end
	end

end
