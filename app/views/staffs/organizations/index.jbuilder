json.array! @organizations do |handler|
  json.id handler.id
  json.name handler.name
  json.form handler.form.form
  json.inn handler.inn
  json.ogrn handler.ogrn
end
