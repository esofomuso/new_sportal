json.array!(electives) do |elective|
  json.extract! elective, :id, :name, :description, :code
  json.url admin_electives_path(elective, format: :json)
end
