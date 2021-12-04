json.extract! student, :id, :sid, :name, :status, :school_id, :created_at, :updated_at
json.url student_url(student, format: :json)
