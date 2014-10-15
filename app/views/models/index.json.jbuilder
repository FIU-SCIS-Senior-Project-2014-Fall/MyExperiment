json.array!(@models) do |model|
  json.extract! model, :id, :content, :user_id
  json.url model_url(model, format: :json)
end
