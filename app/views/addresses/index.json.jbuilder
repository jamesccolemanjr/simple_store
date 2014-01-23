json.array!(@addresses) do |address|
  json.extract! address, :id, :name, :address1, :address2, :city, :state, :zip, :user_id
  json.url address_url(address, format: :json)
end
