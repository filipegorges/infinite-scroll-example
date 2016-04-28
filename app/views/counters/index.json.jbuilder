json.array!(@counters) do |counter|
  json.extract! counter, :id, :iteration
  json.url counter_url(counter, format: :json)
end
