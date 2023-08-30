json.extract! response, :id, :user_id, :survey_id, :message, :created_at, :updated_at
json.url response_url(response, format: :json)
