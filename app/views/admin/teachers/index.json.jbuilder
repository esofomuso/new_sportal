json.array!(teachers) do |teacher|
  json.extract! teacher, :id, :export_id, :first_name, :last_name, preferred_name, email, active
  json.url admin_teachers_path(teacher, format: :json)
end
