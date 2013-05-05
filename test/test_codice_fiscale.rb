require 'minitest/autorun'

require 'codice_fiscale'

class TestCodiceFiscale < MiniTest::Unit::TestCase

	def test_valid_codice_fiscale
		cfs = ['MRARSS00A01H501B',
		       'MRNLCU00A01H501J',
		       'MRORSS00A00A000U',
		       'C' * 16,
		       'G' * 16]

		cfs.each do |cf|
				assert(CodiceFiscale.valid?(cf),
				       "Expected #{cf} to be valid.")
		end
	end

	def test_invalid_codice_fiscale
		cfs = ['MRARSS00A01H501A',
		       'MRNLCU00A01H501I',
		       'B' * 16,
		       'C' * 15,
		       '',
		       ' ']

		cfs.each do |cf|
			assert(!CodiceFiscale.valid?(cf),
			       "Expected #{cf} to be NOT valid.")
		end
	end

end
