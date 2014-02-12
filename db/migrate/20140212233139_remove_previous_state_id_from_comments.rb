class RemovePreviousStateIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :PreviousStateId, :integer
  end
end
