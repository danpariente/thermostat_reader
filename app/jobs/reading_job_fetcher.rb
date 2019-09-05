class ReadingJobFetcher
  def initialize(tracking_number, queue_class: Sidekiq::Queue)
    @tracking_number = tracking_number
    @queue = queue_class.new(ThermostatDataJob.queue_name)
  end

  def fetch
    @job = find_job
    build_reading
  rescue
    raise ActiveRecord::RecordNotFound
  end

  private

  attr_reader :tracking_number, :queue, :job

  def find_job
    queue.find do |job|
      tracking_number_match?(job)
    end
  end

  def build_reading
    Readings.new(normalized_attributes)
  end

  def tracking_number_match?(job)
    attributes_for(job).fetch("tracking_number") == tracking_number.to_i
  end

  def normalized_attributes
    attributes_for(job).except!("_aj_hash_with_indifferent_access")
  end

  def attributes_for(job)
    @job_attrs ||= job&.display_args.first
  end
end
