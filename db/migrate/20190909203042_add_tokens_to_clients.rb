class AddTokensToClients < ActiveRecord::Migration[6.0]
  def up
    add_column :clients, :provider, :string, null: false, default: 'email'
    add_column :clients, :uid, :string, null: false, default: ''
    add_column :clients, :tokens, :text

    Client.reset_column_information

    Client.find_each do |user|
      user.uid = user.email
      user.provider = 'email'
      user.save!
    end

    add_index :clients, [:uid, :provider], unique: true
  end

  def down
    remove_columns :clients, :provider, :uid, :tokens
  end
end
