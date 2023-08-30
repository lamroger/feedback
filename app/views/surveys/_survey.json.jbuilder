json.extract! survey, :id, :user_id, :description, :created_at, :updated_at
json.url survey_url(survey, format: :json)
