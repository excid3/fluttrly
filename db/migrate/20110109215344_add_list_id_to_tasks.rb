class AddListIdToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :list_id, :integer
  end

  def self.down
  end
end
