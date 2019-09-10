require "rails_helper"

RSpec.describe "GET /api/v1/thermostats/:thermostat_id/stats" do
  it "returns stats for specific thermostat" do
    thermostat = create(:thermostat)
    create(:reading, thermostat: thermostat, temperature: 100.0)
    create(:reading, thermostat: thermostat, temperature: 0)

    get "/api/v1/thermostats/#{thermostat.id}/stats",
    headers: set_headers(thermostat.household_token), as: :json

    expect(response.status).to eq(200)

    stats_json = json_body["data"]
    expect(stats_json).to eq({
      "id" =>  thermostat.id,
      "type" => "stats",
      "attributes" => {
        "temperature" => {
          "average" => 50.0,
          "maximum" => 100.0,
          "minimum" => 0.0
        },
        "humidity" => {
          "average" => 15.0,
          "maximum" => 15.0,
          "minimum" => 15.0
        },
        "battery_charge" => {
          "average" => 20.0,
          "maximum" => 20.0,
          "minimum" => 20.0
        }
      },
      "relationships" => {
        "thermostat" => {
          "data" => {
            "id" => thermostat.id,
            "type"=>"thermostat"
          }
        }
      }
    })
  end
end
