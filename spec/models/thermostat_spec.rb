require "rails_helper"

RSpec.describe Thermostat do
  it { should validate_uniqueness_of(:household_token) }
  it { should have_many(:readings).dependent(:destroy) }

  describe "#readings" do
    it "returns the readings ordered by tracking_number" do
      thermostat = create(:thermostat)

      older_reading = create(:reading, thermostat: thermostat, tracking_number: 1)
      newer_reading = create(:reading, thermostat: thermostat, tracking_number: 3)

      expect(thermostat.readings).to match([older_reading, newer_reading])
    end
  end

  describe "#readings_count" do
    it "returns the number of readings the thermostat has" do
      thermostat = create(:thermostat)
      create(:reading, thermostat: thermostat)
      create(:reading, thermostat: thermostat)

      expect(thermostat.readings_count).to eq(2)
    end
  end
end
