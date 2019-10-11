json.array! @organizations do |organization|
  json.id organization.id
  json.name organization.name
  json.form organization.form.form
  json.inn organization.inn
  json.ogrn organization.ogrn
end
