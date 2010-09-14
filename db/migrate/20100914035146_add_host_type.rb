class AddHostType < ActiveRecord::Migration
  def self.up
    add_column(:hosts, :type, :string, :default=>nil)
  end

  def self.down
    remove_column(:hosts, :type)
  end
end
