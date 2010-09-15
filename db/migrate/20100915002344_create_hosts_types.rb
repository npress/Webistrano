class CreateHostsTypes < ActiveRecord::Migration
  def self.up
    create_table "hosts_types", :id => false do |t|
      t.integer "host_id"
      t.integer "type_id"
      
    end
#    hosts_types.create :type_id => Type.find_by_name("db").id
#                       :host_id =>
    
  end

  def self.down
    drop_table "hosts_types"
  end
end
