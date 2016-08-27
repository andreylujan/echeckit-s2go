# -*- encoding : utf-8 -*-
class UploadPdfJob < ActiveJob::Base
	queue_as :eretail_report

	def perform(report_id, regenerate_uuid=false)
		report = Report.find_by_id(report_id)
		if report.nil?
			return
		end
		ac = ActionController::Base.new()
		# html = ac.render_to_string('templates/report.html.erb', 
		# html = ac.render_to_string('templates/report2.html.erb',
		
		html = (ac.render_to_string('templates/' + report.organization_id.to_s + '/' + report.report_type_id.to_s + '.html.erb',
			locals: { :@report => report })).force_encoding("UTF-8")
		
		pdf = WickedPdf.new.pdf_from_string(html, zoom: 0.8)
		file = Tempfile.new('pdf', encoding: 'ascii-8bit')
		begin
		   file.write(pdf)
		   if regenerate_uuid
		   	report.set_uuid
		   end
		   report.pdf = file
		   report.save
		   report.update_attribute :pdf_uploaded, true
		ensure
		   file.close
		   file.unlink   # deletes the temp file
		end
	end
end
