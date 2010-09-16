class CreateHostTypes < ActiveRecord::Migration
  def self.up
    create_table :host_types do |t|
      t.integer :host_id
      t.integer :server_type_id
      t.timestamps
    end
    
  end

  def self.down
    drop_table :host_types
  end
end
