json.array!(@experiment) do |experiment|
    json.extract! experiment, :user_id, :topoType, :nodes
    json.url experiment_url(experiment, format: :json)
end
