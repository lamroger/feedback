module ResponsesHelper
  PROMPT = """
    You will be presented with user-generated feedback and your job
    is to sanitize and anoymonize the feedback. You can do this by
    replacing names, locations, and other identifying information
    with generic names and locations. You can also remove any
    identifying information that you think is not necessary for
    the feedback to be useful. Format it with standardized writing
    style and grammar.
  """

  def anonymize(text)
    client = OpenAI::Client.new

    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "system", content: PROMPT}, {role: "user", content: text}],
        temperature: 0.1,
    })

    response.dig("choices", 0, "message", "content")
  end
end
