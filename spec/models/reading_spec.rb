require 'rails_helper'

RSpec.describe Reading do
  it { should validate_presence_of(:temperature) }
  it { should validate_presence_of(:humidity) }
  it { should validate_presence_of(:battery_charge) }

  it { should belong_to(:thermostat) }
end
