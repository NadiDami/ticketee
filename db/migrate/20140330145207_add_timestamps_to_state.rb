class AddTimestampsToState < ActiveRecord::Migration
  def change
    add_column(:states, :created_at, :datetime)
    add_column(:states, :updated_at, :datetime)
  end
end
