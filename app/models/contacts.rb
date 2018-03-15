class Contacts < ApplicationRecord
  self.primary_key = :contact_id
  belongs_to :users, optional: true
  serialize :phone_number, Array
  serialize :address, Array
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      columns = %w(name email phone_number address
      city street region country postal_code)
      csv << columns
      all.each do |row|
        csv << row.attributes.values_at(*columns)
      end
    end
  end
  def self.save_contacts contact_entry, user_type
    if user_type != nil
      self.create(contact_entry)
    else
      @contact = self.create({name: contact_entry[:name], email: contact_entry[:email],
        phone_number: contact_entry[:phone_number], address: contact_entry[:address],
        city: contact_entry[:city], street: contact_entry[:street],
        region: contact_entry[:region], postal_code: contact_entry[:postal_code],
        users_id: contact_entry[:users_id], country: contact_entry[:country]})
      @contact.save!
    end
  end
  def self.fetch_contacts user
    self.joins(:users).where("users.users_id" => user.users_id)
  end
  def self.edit_contact contact_entry
    self.update(contact_entry["contact_id"], :name => contact_entry[:name], :email => contact_entry[:email],
      phone_number: contact_entry[:phone_number], address: contact_entry[:address],
      :city => contact_entry[:city], :street => contact_entry[:street],
      :region => contact_entry[:region], :postal_code => contact_entry[:postal_code], :country => contact_entry[:country])
  end
  def self.delete_contact contactId
    self.delete(contactId)
  end
end
