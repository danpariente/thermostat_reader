class AddReadingsCountToThermostat < ActiveRecord::Migration[6.0]
  def change
    add_column :thermostats, :readings_count, :integer, default: 0
  end
end
