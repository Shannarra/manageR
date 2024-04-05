class CreateReportJob
  include Sidekiq::Job

  def perform(report:)
    @report = report
    @report.update!(state: :in_progress)

    @filename = "#{@report.created_at.strftime('%d %B %Y')}_#{@report.name}_#{@report.creation_scope}-#{@report.by.name}"

    info = report_info
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

    File.delete(file.path)
  end

  private
  def classes_info(institution)
    h = Hash.new
    institution.i_classes.each do |klass|
      assoc_users = User.where(i_class: klass)

      h[klass.name] = {
        'Associated Users Count': assoc_users.count,
        'Students': assoc_users.where(access_type: :student).count,
        'Teachers': assoc_users.where(access_type: :teacher).count,
      }
    end
    h
  end

  def subjects_info(institution)
    h = Hash.new

    institution.subjects.each do |subject|
      h[subject.name] = {
        'Lead Teacher': subject.user.name,
        'Part of class': subject.i_class.name
      }
    end

    h
  end

  def report_info
    @info = Hash.new

    institution = @report.institution
    @info[:institution] = {
      Institution: institution.name,
      'Users Count': institution.users.count,
      'Classes Count': institution.i_classes.count,
      'Subjects Count': institution.subjects.count,
    } if @report.institution?

    @info[:classes] = classes_info(institution) if Report.creation_scopes[@report.creation_scope] > 1
    @info[:subjects] = subjects_info(institution)
  end

  def generate_csv
    p 'generating csv'

    f = File.new("report_#{@filename}.csv", 'w')

    report_csv = CSV.generate do |data|
      if @report.institution?
        data << ['Institution Info']
        data << [" ", @info[:institution].keys].flatten
        data << [" ", @info[:institution].values].flatten
        data << []
      end

      if Report.creation_scopes[@report.creation_scope] > 1
        data << ['Classes Info']
        @info[:classes].each do |key, vals|
          data << [" ", key]
          data << [" ", " ", *vals.keys]
          data << [" ", " ", *vals.values]
        end
        data << []
      end
      data << ['Subjects Info', ' ', @info[:subjects].first.last.keys].flatten
      @info[:subjects].each do |key, vals|
        data << [" ", key]
        data << [" ", " ", vals.values].flatten
      end
    end

    f.write(report_csv)

    f
  end

  def generate_json
    p 'generating json'

    f = File.new("report_#{@filename}.json", 'w')

    f.write(@info.to_json)

    f
  end

  def generate_pdf
    p 'generating pdf'

    f = File.new("report_#{@filename}.pdf", 'w')
  end
end
