namespace :reports do
  task run: :environment do
    reports = Report.requested

    exit(0) if reports.count.zero? # nothing to do, exit immediately

    puts "Running #{Report.requested.count} requested reports."

    reports.each do |request|
      CreateReportJob.new.perform(report: request)
    end
  end
end 
