module ResponseHelper
  def json_response
    response = JSON.parse(@response.body)
    response.is_a?(Array) ? response.map(&:deep_symbolize_keys) : response.deep_symbolize_keys
  end
end
