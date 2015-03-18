json.array!(students) do |student|
  json.extract! student, :id, :export_id, :first_name, :last_name, preferred_name, email, active
  json.url admin_students_path(student, format: :json)
end
