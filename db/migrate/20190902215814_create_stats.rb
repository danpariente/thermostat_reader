class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_view :stats
  end
end
