class GenerateCsvReportJob
  def perform(report:, filename:, info:)
    @report = report
    @filename = filename
    @info = info

    generate_csv
  end

  def generate_csv
    p 'generating csv'

    f = File.new("report_#{@filename}.csv", 'w')

    report_csv = CSV.generate do |data|
      write_institution_info(data)
      write_classes_info(data)
      write_subjects_info(data)
      write_attendances_info(data)
    end

    f.write(report_csv)

    f
  end

  def write_institution_info(data)
    if @report.institution?
      data << ['Institution Info']
      data << [" ", @info[:institution].keys].flatten
      data << [" ", @info[:institution].values].flatten
      data << []
    end
  end

  def write_classes_info(data)
    if Report.creation_scopes[@report.creation_scope] > 1
      data << ['Classes Info']
      @info[:classes].each do |key, vals|
        data << [" ", key]
        data << [" ", " ", *vals.keys]
        data << [" ", " ", *vals.values]
      end
      data << []
    end
  end

  def write_subjects_info(data)
    data << ['Subjects Info', ' ', @info[:subjects].first.last.keys].flatten
    @info[:subjects].each do |key, vals|
      data << [" ", key]
      data << [" ", " ", vals.values].flatten
    end
  end

  def write_attendances_info(data)
    data << ['Attendances Info', ' ', @info[:attendances].first.last.keys].flatten
    @info[:attendances].each do |key, vals|
      data << [" ", key]
      data << [" ", " ", vals.values].flatten
    end
  end
end
