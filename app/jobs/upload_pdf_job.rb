class UploadPdfJob < ActiveJob::Base
	queue_as :default

	def perform(report_id)
		report = Report.find(report_id)
		ac = ActionController::Base.new()
		# html = ac.render_to_string('templates/report.html.erb', 
		# html = ac.render_to_string('templates/report2.html.erb',

		html = (ac.render_to_string('templates/' + report.organization_id.to_s + '/report.html.erb',
			locals: { :@report => report })).force_encoding("UTF-8")
		pdf = WickedPdf.new.pdf_from_string(html, zoom: 0.8)
		file = Tempfile.new('pdf', encoding: 'ascii-8bit')
		begin
		   file.write(pdf)
		   report.pdf = file
		   report.save
		ensure
		   file.close
		   file.unlink   # deletes the temp file
		end
	end
end
