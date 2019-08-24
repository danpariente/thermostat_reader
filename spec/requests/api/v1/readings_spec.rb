require "rails_helper"

RSpec.describe "GET /api/v1/thermostats/:thermostat_id/readings/:tracking_number" do
  it "returns a reading" do
    reading = create(:reading)
    thermostat = reading.thermostat

    get "/api/v1/thermostats/#{thermostat.id}/readings/#{reading.tracking_number}"

    expect(response.status).to eq(200)

    reading_json = json_body["data"]
    expect(reading_json).to eq({
      "id" =>  reading.id,
      "type" => "reading",
      "attributes" => {
        "tracking_number" => reading.tracking_number,
        "temperature" => reading.temperature,
        "humidity" => reading.humidity,
        "battery_charge" => reading.battery_charge,
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

  context "when reading is not found" do
    it "responds with a 404 Not Found status" do
      thermostat = create(:thermostat)
      nonexistent_tracker_number = 371

      get "/api/v1/thermostats/#{thermostat.id}/readings/#{nonexistent_tracker_number}"

      expect(response.status).to eq(404)
      expect(json_body.fetch("errors")).not_to be_empty
    end
  end
end

RSpec.describe "POST /api/v1/thermostats/:thermostat_id/readings" do
  it "collects the reading with a Created status" do
    thermostat = create(:thermostat)
    reading_params = attributes_for(:reading)

    post "/api/v1/thermostats/#{thermostat.id}/readings", params: { reading: reading_params }

    expect(response.status).to eq(201)
    expect(json_body.dig("data", "attributes", "tracking_number")).to eq(reading_params[:tracking_number])
  end

  context "when there are invalid attributes" do
    it "returns 422 Unprocessable Entity with errors" do
      thermostat = create(:thermostat)
      reading_params = attributes_for(:reading, :invalid)

      post "/api/v1/thermostats/#{thermostat.id}/readings", params: { reading: reading_params }

      expect(response.status).to eq(422)
      expect(json_body.fetch("errors")).not_to be_empty
    end
  end
end
