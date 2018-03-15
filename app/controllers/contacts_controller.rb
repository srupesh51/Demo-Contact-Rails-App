class ContactsController < ApplicationController
  include ContactsHelper
  helper_method :check_filter_cache, :delete_filter_cache, :exists
  def create
  end
  def edit
    @contact = Contacts.where({contact_id: params["contact"]})
    respond_to do |format|
      format.html
    end
  end
  def delete
    Contacts.delete_contact(params[:contact])
  end
  def edit_personal_contacts
    Contacts.edit_contact(params)
    redirect_to root_path
  end
  def show
    if current_contact == nil && current_user.user_type == 'normal'
      flash[:error] = "Sorry No Contacts Exist! Please Add atleast 1 Contact"
    else
      @filtered = check_filter_cache
      if exists
        @contacts = @filtered
      else
        @contacts = Contacts.fetch_contacts(current_user)
        Rails.cache.write("contacts", @contacts)
      end
      respond_to do |format|
        format.html
        format.csv { send_data @contacts.to_csv, filename: "contacts-#{Date.today}.csv" }
      end
    end
  end

  def save_personal_contacts
      currentUser = current_user
      params[:users_id] = currentUser.users_id
      isSaved = Contacts.save_contacts(params, nil)
      if !isSaved
          flash[:notice] = "Sorry There Was An Error While Saving Your Contacts! Please try again"
          redirect_to '/contacts/create'
      else
        redirect_to root_path
      end
  end

  def filter
    @contacts = Rails.cache.read('contacts')
    list = []
    list1 = []
    list2 = []
    list3 = []
    list4 = []
    list5 = []
    list6 = []
    list7 = []
    list8 = []
    list9 = []
    result = []
    if params["phone_number"] != nil && !params["phone_number"].empty?
      @contacts.each do |contact|
        contact[:phone_number].each do |phone_number|
          params["phone_number"].each do |phone|
            if phone_number == phone
              list.push(contact)
            end
          end
        end
      end
    end
    if params["email"] != nil
      @contacts.each do |contact|
        if contact[:email] == params["email"]
          list1.push(contact)
        end
      end
    end
    if params["name"] != nil
      @contacts.each do |contact|
        if contact[:name] == params["name"]
          list2.push(contact)
        end
      end
    end
    if params["postal_code"] != nil
      @contacts.each do |contact|
        if contact[:postal_code] == params["postal_code"]
          list3.push(contact)
        end
      end
    end
    if params["country"] != nil
      @contacts.each do |contact|
        if contact[:country] == params["country"]
          list4.push(contact)
        end
      end
    end
    if params["address"] != nil && !params["address"].empty?
      @contacts.each do |contact|
        contact[:address].each do |address|
          params["address"].each do |addr|
            if address == addr
              list4.push(contact)
            end
          end
        end
      end
    end
    if params["city"] != nil
      @contacts.each do |contact|
        if contact[:city] == params["city"]
          list7.push(contact)
        end
      end
    end
    if params["street"] != nil
      @contacts.each do |contact|
        if contact[:street] == params["street"]
          list8.push(contact)
        end
      end
    end
    if params["region"] != nil
      @contacts.each do |contact|
        if contact[:region] == params["region"]
          list9.push(contact)
        end
      end
    end
    list.each do |list|
      result.push(list)
    end
    list1.each do |list|
      result.push(list)
    end
    list2.each do |list|
      result.push(list)
    end
    list3.each do |list|
      result.push(list)
    end
    list4.each do |list|
      result.push(list)
    end
    list5.each do |list|
      result.push(list)
    end
    list6.each do |list|
      result.push(list)
    end
    list7.each do |list|
      result.push(list)
    end
    list8.each do |list|
      result.push(list)
    end
    list9.each do |list|
      result.push(list)
    end
    if !result.empty?
      @filtered = result.uniq
      Rails.cache.write("filtered", @filtered)
    end
    if params["reset_model"]
       redirect_to contacts_reset_path
    else
      if result.empty?
        Rails.cache.write("filtered", [])
      end
      redirect_to contacts_show_path
    end
  end
  def reset
    redirect_to contacts_show_path
  end
end
