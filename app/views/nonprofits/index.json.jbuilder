json.array!(@nonprofits) do |nonprofit|
  json.extract! nonprofit, :id, :name, :email, :description
  json.url nonprofit_url(nonprofit, format: :json)
end
