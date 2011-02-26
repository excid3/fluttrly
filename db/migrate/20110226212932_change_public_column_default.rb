class ChangePublicColumnDefault < ActiveRecord::Migration
  def self.up
    change_column_default :lists, :public, :true
  end

  def self.down
    change_column_default :lists, :public, :false
  end
end
