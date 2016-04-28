json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :content, :author
  json.url task_url(task, format: :json)
end
