class CreateAllowedIpAddresses < ActiveRecord::Migration
  def self.up
    create_table :allowed_ip_addresses do |t|
      t.string(:ip_address, :null=>false)
      t.timestamps
    end
    AllowedIpAddress.create(:ip_address=>"10.42.42.*");
    AllowedIpAddress.create(:ip_address=>"10.42.42.131");
    AllowedIpAddress.create(:ip_address=>"127.0.0.1");
  end

  def self.down
    drop_table :allowed_ip_addresses
  end
end
