json.array! @clients do |client|
  json.fullname client.fullname
  json.phone client.phone
  json.email client.email
end
