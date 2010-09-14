class AddDefaultHosts < ActiveRecord::Migration
  def self.up
     Host.create(:name=>"10.42.42.131", :type=>"web")
     Host.create(:name=>"10.42.42.3", :type=>"db")
     Host.create(:name=>"10.42.42.110", :type=>"cd")
  end

  def self.down
     Host.find_by_name("10.42.42.131")
     Host.find_by_name("10.42.42.3")
     Host.find_by_name("10.42.42.110")
  end
end
