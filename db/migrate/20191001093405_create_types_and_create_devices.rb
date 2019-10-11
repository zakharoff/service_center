class CreateTypesAndCreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :type_devices do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :devices do |t|
      t.string :name, null: false
      t.references :type_device, foreign_keys: true
      t.string :serial_num, null: false
      t.timestamps
    end
  end
end
