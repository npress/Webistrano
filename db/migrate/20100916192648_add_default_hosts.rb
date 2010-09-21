class AddDefaultHosts < ActiveRecord::Migration
  
  def self.up
    
     h=Host.create(:name=>"10.42.42.131")
     HostType.create(:host=>h, :server_type=>ServerType.find_by_name("db"))
     h=Host.create(:name=>"10.42.42.3")
     HostType.create(:host=>h, :server_type=>ServerType.find_by_name("web")) 
     h=Host.create(:name=>"10.42.42.110")
     HostType.create(:host=>h, :server_type=>ServerType.find_by_name("game"))
     HostType.create(:host=>h, :server_type => ServerType.find_by_name("content"))
  end

  def self.down
     Host.find_by_name("10.42.42.131").destroy
     Host.find_by_name("10.42.42.3").destroy
     Host.find_by_name("10.42.42.110").destroy
  end
end
