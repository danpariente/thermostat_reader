class CreateReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :readings, id: :uuid do |t|
      t.integer :tracking_number, null: false, default: 1
      t.float :temperature, null: false, default: 0
      t.float :humidity, null: false, default: 0
      t.float :battery_charge, null: false, default: 0
      t.references :thermostat, type: :uuid, null: false, index: true

      t.timestamps null: false
    end
    add_foreign_key :readings, :thermostats, on_delete: :cascade
  end
end
