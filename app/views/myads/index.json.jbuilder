json.array!(@myads) do |myad|
  json.extract! myad, :id, :title, :description
  json.url myad_url(myad, format: :json)
end
