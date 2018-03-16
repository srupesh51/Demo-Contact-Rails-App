class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts, :id => false do |t|
      t.primary_key :contact_id, :integer
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :city
      t.string :street
      t.string :region
      t.string :country
      t.string :postal_code
    end
    add_reference :contacts, :users, type: :integer
  end
end
