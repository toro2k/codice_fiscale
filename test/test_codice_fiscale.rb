require 'test/unit'

require 'codice_fiscale'

class TestCodiceFiscale < Test::Unit::TestCase

	def test_parsing_errors
		assert_raises(ArgumentError) { CodiceFiscale.parse('') }
		assert_raises(ArgumentError) { CodiceFiscale.parse('#') }
		assert_raises(ArgumentError) { CodiceFiscale.parse('BNFC') }
		assert_raises(TypeError) { CodiceFiscale.parse([]) }
	end

	def test_valid_codice_fiscale
		cfs = ['MRARSS00A01H501B',
		      'MRNLCU00A01H501J']

		cfs.each do |cf|
				assert(CodiceFiscale.parse(cf).valid?,
				       "Expected #{cf} to be valid.")
		end
	end

	def test_unvalid_codice_fiscale
		cfs = ['MRARSS00A01H501A',
		       'MRNLCU00A01H501I']

		cfs.each do |cf|
			assert(!CodiceFiscale.parse(cf).valid?,
			       "Expected #{cf} to be NOT valid.")
		end
	end

end
