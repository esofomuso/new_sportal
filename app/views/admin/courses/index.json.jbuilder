json.array!(courses) do |course|
  json.extract! course, :id, :name, :description, :code
  json.url admin_courses_path(course, format: :json)
end
