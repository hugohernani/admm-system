json.array!(@bloggers) do |blogger|
  json.extract! blogger, :id, :theme, :description, :user_id
  json.url blogger_url(blogger, format: :json)
end
