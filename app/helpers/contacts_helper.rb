module ContactsHelper
  def check_filter_cache
    Rails.cache.read("filtered")
  end
  def exists
    Rails.cache.exist?("filtered")
  end
  def delete_filter_cache
    Rails.cache.delete("filtered")
  end
  def get_deep(h, *fields)
    fields.inject(h) { |acc, e| acc[e] if acc.is_a?(Hash) || (e.is_a?(Integer) && acc.respond_to?(:[])) }
  end

  def parse_contact response, user
    contacts = []
    contactList = response['feed']['entry'].collect do |k|
      {
        name: k["title"]["$t"],
        email: get_deep(k["gd$email"], 0, "address"),
        phone_number: [get_deep(k["gd$phoneNumber"], 0, "$t")],
        address: [get_deep(k["gd$structuredPostalAddress"],0,"address_1"),
        get_deep(k["gd$structuredPostalAddress"],0,"address_2")],
        city: get_deep(k["gd$structuredPostalAddress"],0,"city"),
        street: get_deep(k["gd$structuredPostalAddress"],0,"street"),
        region: get_deep(k["gd$structuredPostalAddress"],0,"region"),
        country: get_deep(k["gd$structuredPostalAddress"],0,"country"),
        postal_code: get_deep(k["gd$structuredPostalAddress"],0,"postcode"),
        users_id: user.users_id
    }
    end
    contacts = contactList
    result = contacts.each { |h|
        if h[:name].nil? || h[:name] == ""
          h.delete(:name)
        end
        if h[:email].nil? || h[:email] == ""
          h.delete(:email)
        end
        if h[:city].nil? || h[:city] == ""
          h.delete(:city)
        end
        if h[:street].nil? || h[:street] == ""
            h.delete(:street)
        end
        if h[:region].nil? || h[:region] == ""
          h.delete(:region)
        end
        if h[:country].nil? || h[:country] == ""
            h.delete(:country)
        end
        if h[:postal_code].nil? || h[:postal_code] == ""
            h.delete(:postal_code)
        end
        h.each do |key,values|
          values.is_a?(Array) && values.each do |value|
            if value.nil? || value == ""
              h.delete(key)
            end
          end
        end
      }
    result
  end
end
