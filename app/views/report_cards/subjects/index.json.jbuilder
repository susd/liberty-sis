json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :report_card_id, :major
  json.url subject_url(subject, format: :json)
end
