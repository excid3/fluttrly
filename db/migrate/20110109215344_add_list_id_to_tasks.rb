class AddListIdToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :list_id, :integer
    Task.all.each do |t|
      list = List.find_or_create_by_name t.name
      list.save
      t.list = list
      t.save
    end
  end

  def self.down
    remove_column :tasks, :list_id, :integer
  end
end
