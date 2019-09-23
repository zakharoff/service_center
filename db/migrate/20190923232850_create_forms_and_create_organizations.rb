class CreateFormsAndCreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :forms do |t|
      t.string :form, null: false
      t.timestamps
    end

    create_table :organizations do |t|
      t.string :name, null: false
      t.references :form, foreign_keys: true
      t.string :inn, null: false
      t.string :ogrn, null: false
      t.timestamps
    end
  end
end
