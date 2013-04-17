require 'test/unit'

require 'codice_fiscale'

class TestCodiceFiscale < Test::Unit::TestCase

	def test_parsing_errors
		assert_raises(ArgumentError) { CodiceFiscale.parse('') }
		assert_raises(ArgumentError) { CodiceFiscale.parse('#') }
		assert_raises(ArgumentError) { CodiceFiscale.parse('BNFC') }
	end

	def test_valid_codice_fiscale
		cf = 'MRARSS00A01H501B'
		assert(CodiceFiscale.parse(cf).valid?,
		       "Expected #{cf} to be valid.")
	end

	def test_unvalid_codice_fiscale
		cf = 'MRARSS00A01H501A'
		assert(!CodiceFiscale.parse(cf).valid?,
		       "Expected #{cf} to be NOT valid.")
	end

end
