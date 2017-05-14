class AddDateColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :created_at, :datetime
  end
end

