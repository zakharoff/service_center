json.array! @devices do |device|
  json.id device.id
  json.name device.name
  json.type device.type_device.name
  json.serialNum device.serial_num
end
