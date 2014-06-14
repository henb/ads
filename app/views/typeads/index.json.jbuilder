json.array!(@typeads) do |typead|
  json.extract! typead, :id, :name, :text
  json.url typead_url(typead, format: :json)
end
