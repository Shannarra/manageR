json.extract! attendance, :id, :type, :teacher_id, :student_id, :klass_id, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
