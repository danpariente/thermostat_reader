require "rails_helper"

RSpec.describe Thermostat do
  it { should validate_presence_of(:household_token) }
  it { should validate_uniqueness_of(:household_token) }
end
