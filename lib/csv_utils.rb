module CsvUtils
	require 'charlock_holmes'

	def self.load_csv(csv_path)
		csv_file = File.open(csv_path, 'r')
		contents = csv_file.read
		detection = CharlockHolmes::EncodingDetector.detect(contents)
		contents.force_encoding detection[:encoding]
		contents.encode! "UTF-8"
		csv = CSV.parse(contents, { headers: false, encoding: "UTF-8", col_sep: ';' })
		csv_file.close
		csv
	end
end