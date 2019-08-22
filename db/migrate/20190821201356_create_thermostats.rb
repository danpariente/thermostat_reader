class CreateThermostats < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
     CREATE TYPE address AS
     (
       name VARCHAR(90),
       street VARCHAR(90),
       city VARCHAR(90),
       state VARCHAR(90),
       zipcode VARCHAR(10)
     );
    SQL

    create_table :thermostats, id: :uuid do |t|
      t.text :household_token, null: false, index: { unique: true }
      t.column :location, :address, null: false, default: "(,,,,)"

      t.timestamps null: false
    end
  end

  def down
    drop_table :thermostats

    execute "DROP TYPE address;"
  end
end
