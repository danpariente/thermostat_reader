require "sidekiq/api"

class ReadingJobFetcher
  def initialize(*tracking_numbers, queue_class: Sidekiq::Queue)
    @tracking_numbers = tracking_numbers
    @queue = queue_class.new(ThermostatDataJob.queue_name)
  end

  def fetch
    find_jobs
    fail ActiveRecord::RecordNotFound if jobs.empty?
    build_readings
  end

  private

  attr_reader :tracking_numbers, :queue, :jobs

  def find_jobs
    @jobs = queue.select do |job|
      tracking_number_match?(job)
    end
  end

  def build_readings
    readings = jobs.map do |job|
      Reading.new(normalized_attributes(job))
    end
    tracking_numbers.one? ? readings.first : readings
  end

  def tracking_number_match?(job)
    tracking_numbers.map(&:to_i).include?(attributes_for(job).fetch("tracking_number"))
  end

  def normalized_attributes(job)
    attributes_for(job).except!("_aj_hash_with_indifferent_access")
  end

  def attributes_for(job)
    job&.display_args.first
  end
end
