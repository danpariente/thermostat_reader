require "rails_helper"

RSpec.describe Stats do
  context "#temperature" do
    it "returns updated temperature stats" do
      thermostat = create(:thermostat)
      create(:reading, thermostat: thermostat)
      create(:reading, thermostat: thermostat)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      stats = Stats.find(thermostat.id)
      allow(stats).to receive(:fetcher).and_return(120)

      result = stats.temperature

      expect(result["average"]).to eq(106.67)
      expect(result["maximum"]).to eq(120.0)
      expect(result["minimum"]).to eq(100.0)
    end
  end

  context "#humidity" do
    it "returns updated humidity stats" do
      thermostat = create(:thermostat)
      create(:reading, thermostat: thermostat)
      create(:reading, thermostat: thermostat)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      stats = Stats.find(thermostat.id)
      allow(stats).to receive(:fetcher).and_return(120)

      result = stats.humidity

      expect(result["average"]).to eq(50.0)
      expect(result["maximum"]).to eq(120.0)
      expect(result["minimum"]).to eq(15.0)
    end
  end

  context "#battery_charge" do
    it "returns updated battery_charge stats" do
      thermostat = create(:thermostat)
      create(:reading, thermostat: thermostat)
      create(:reading, thermostat: thermostat)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      Thermostat.increment_counter(:readings_count, thermostat.id, touch: true)
      stats = Stats.find(thermostat.id)
      allow(stats).to receive(:fetcher).and_return(120)

      result = stats.battery_charge

      expect(result["average"]).to eq(53.33)
      expect(result["maximum"]).to eq(120.0)
      expect(result["minimum"]).to eq(20.0)
    end
  end
end
