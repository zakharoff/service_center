class AddTokensToStaffs < ActiveRecord::Migration[6.0]
  def up
    add_column :staffs, :provider, :string, null: false, default: 'email'
    add_column :staffs, :uid, :string, null: false, default: ''
    add_column :staffs, :tokens, :text

    Staff.reset_column_information

    Staff.find_each do |user|
      user.uid = user.email
      user.provider = 'email'
      user.save!
    end

    add_index :staffs, [:uid, :provider], unique: true
  end

  def down
    remove_columns :staffs, :provider, :uid, :tokens
  end
end
