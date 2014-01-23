json.array!(@products) do |product|
  json.extract! product, :id, :sku, :name, :description, :ohb, :price, :category_id, :um
  json.url product_url(product, format: :json)
end
