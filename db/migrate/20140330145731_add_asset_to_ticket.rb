class AddAssetToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :asset, :string
  end
end
