class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts, :primary_key => :contact_id do |t|
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :city
      t.string :street
      t.string :region
      t.string :country
      t.string :postal_code
      t.references :users
      add_foreign_key :contacts, :users, column: :users_id, primary_key: "users_id"
    end
  end
end
