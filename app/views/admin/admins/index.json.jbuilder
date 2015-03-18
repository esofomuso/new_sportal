json.array!(admins) do |admin|
  json.extract! admin, :id, :export_id, :first_name, :last_name, preferred_name, email, active
  json.url admin_admins_path(admin, format: :json)
end
