require "rails_helper"

RSpec.describe ReadingJobFetcher do
  context "#fetch" do
    it "returns one reading object when the input is one tracking number" do
      fetcher = ReadingJobFetcher.new(127)
      job_params = attributes_for(:reading, tracking_number: 127)
      job = double("job", display_args: [job_params])
      allow(fetcher).to receive(:jobs).and_return([job])

      result = fetcher.fetch

      expect(result.attributes).to eq(Reading.new(job_params).attributes)
    end

    it "returns multiple reading objects when the input is multiple tracking numbers" do
      fetcher = ReadingJobFetcher.new(127, 128)
      job_params1 = attributes_for(:reading, tracking_number: 127)
      job_params2 = attributes_for(:reading, tracking_number: 128)
      job1 = double("job", display_args: [job_params1])
      job2 = double("job", display_args: [job_params2])
      allow(fetcher).to receive(:jobs).and_return([job1, job2])

      result = fetcher.fetch

      expect(result.map(&:attributes)).to eq(
        [Reading.new(job_params1), Reading.new(job_params2)].map(&:attributes)
      )
    end
  end
end
