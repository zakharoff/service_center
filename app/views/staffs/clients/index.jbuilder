json.array! @clients do |client|
  json.id client.id
  json.fullname client.fullname
  json.phone client.phone
  json.email client.email
end
