class CreateReportJob
  include Sidekiq::Job

  def perform(report:)
    @report = report
    @report.update!(state: :in_progress)

    @report_date = @report.created_at.strftime('%d %B %Y')
    @filename = "#{@report_date}_#{@report.name}_#{@report.creation_scope}-#{@report.by.name}"

    generate_report_info!

    file = case report.format
           when 'pdf' then GeneratePdfReportJob.new.perform(report: report, filename: @filename, info: @info)
           when 'json' then generate_json # no need for separate job, it's literally a #to_json call.
           when 'csv' then GenerateCsvReportJob.new.perform(report: report, filename: @filename, info: @info)
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

  def attendances_info(institution)
    h = Hash.new

    Attendance.monthly.where(teacher: institution.users).each do |attendace|
      h[attendace.created_at] = {
        'Teacher': attendace.teacher.name,
        'For Class': attendace.i_class.name,
        'Student': attendace.student.name,
        'Attending?': attendace.attendance_type,
      }
    end

    h
  end

  def generate_report_info!
    @info = Hash.new

    institution = @report.institution
    @info[:institution] = {
      Institution: institution.name,
      'Users Count': institution.users.count,
      'Classes Count': institution.i_classes.count,
      'Subjects Count': institution.subjects.count,
    } if @report.institution?

    @info[:classes] = classes_info(institution) if Report.creation_scopes[@report.creation_scope] > 1

    # All reports will contain basic information, regardless
    # of the scope. This includes subjects, overall attendances,
    # exams/grades for the institution, etc.
    @info[:subjects] = subjects_info(institution)
    @info[:attendances] = attendances_info(institution)
  end

  def generate_json
    p 'generating json'

    f = File.new("report_#{@filename}.json", 'w')

    f.write({}.merge("#{@report.institution.name}": @info).to_json)

    f
  end
end
