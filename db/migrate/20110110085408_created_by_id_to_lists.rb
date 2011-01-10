class CreatedByIdToLists < ActiveRecord::Migration
  def self.up
    add_column :lists, :created_by_id, :integer
  end

  def self.down
    remove_column :lists, :created_by_id
  end
end
