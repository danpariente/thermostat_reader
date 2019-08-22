FactoryBot.define do
  factory :thermostat do
    household_token { SecureRandom.base58(24) }
    location { "(New York Stock Exchange, 11 Wall St, New York, NY, 10005)" }
  end

  factory :reading do
    temperature { 100.0 }
    humidity { 15.0 }
    battery_charge { 20.0 }
    thermostat
  end
end
