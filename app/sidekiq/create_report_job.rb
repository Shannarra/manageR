class CreateReportJob
  include Sidekiq::Job


  def perform(report:)
    @report = report
    @report.update!(state: :in_progress)

    @filename = "#{@report.created_at.strftime('%d %B %Y')}_#{@report.name}_#{@report.creation_scope}-#{@report.by.name}"

    file = case report.format
           when 'pdf' then generate_pdf
           when 'json' then generate_json
           when 'csv' then generate_csv
           else
             raise 'This should be unreachable'
           end

    @report.file.store!(file)
    @report.update!(state: :completed)
    @report.save!
  end

  def generate_csv
    p 'generating csv'

    f = File.new("report_#{@filename}.csv", 'w')
  end

  def generate_json
    p 'generating json'

    f = File.new("report_#{@filename}.json", 'w')
  end

  def generate_pdf
    p 'generating pdf'

    f = File.new("report_#{@filename}.pdf", 'w')
  end
end
