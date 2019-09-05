require "rails_helper"

RSpec.describe ThermostatDataJob do
  include ActiveJob::TestHelper

  describe ".collect" do
    it "enqueues the job" do
      thermostat = create(:thermostat)
      reading_params = attributes_for(:reading, thermostat_id: thermostat.id)

      expect do
        ThermostatDataJob.collect(reading_params)
      end.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end
  end

  it "uses the specified queue" do
    queue_name = ThermostatDataJob.new.queue_name

    expect(queue_name).to eq("collect_data")
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
