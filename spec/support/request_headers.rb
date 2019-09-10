module RequestHeaders
  def set_headers(auth_token = nil)
    {
      "thermostat-auth-token" => auth_token,
      "Content-Type" => "application/json"
    }
  end
end

RSpec.configure do |config|
  config.include RequestHeaders
end
