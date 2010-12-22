class SetTaskDefaults < ActiveRecord::Migration
  def self.up
    change_column :tasks, :name, :string, { :null => false }
    change_column :tasks, :content, :string, { :null => false }
    change_column :tasks, :completed, :boolean, { :default => false, :null => false }
  end

  def self.down
  end
end
