json.extract! subject, :id, :name, :year, :description, :teacher_id, :klass_id, :created_at, :updated_at
json.url subject_url(subject, format: :json)
