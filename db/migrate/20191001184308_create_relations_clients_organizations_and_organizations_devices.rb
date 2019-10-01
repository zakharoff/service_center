class CreateRelationsClientsOrganizationsAndOrganizationsDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :clients_organizations do |t|
      t.references :client, foreign_key: true, null: false
      t.references :organization, foreign_key: true, null: false

      t.timestamps
    end

    add_reference :devices, :organization, foreign_key: true
  end
end
