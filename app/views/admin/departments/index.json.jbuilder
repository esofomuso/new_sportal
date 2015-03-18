json.array!(departments) do |department|
  json.extract! department, :id, :name, :description, :code
  json.url admin_departments_path(department, format: :json)
end
