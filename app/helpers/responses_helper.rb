module ResponsesHelper
  PROMPT = <<-PROMPT
      You will be presented with user-generated feedback delimited by triple quotes.
      Sanitize and anonymize the feedback.
      Replace names, locations, and other identifying information with generic names and locations.
      Remove any identifying information that you think is not necessary for the feedback to be useful.
      Format it with standardized writing style and grammar.
  PROMPT

  def anonymize(text)
    client = OpenAI::Client.new

    content = <<-CONTENT
      """#{text}"""
    CONTENT

    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo', # Required.
        messages: [{ role: 'system', content: PROMPT }, { role: 'user', content: }],
        temperature: 0.1
      }
    )

    response.dig('choices', 0, 'message', 'content')
  end
end
