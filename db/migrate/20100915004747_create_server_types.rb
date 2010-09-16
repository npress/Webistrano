class CreateServerTypes < ActiveRecord::Migration
  def self.up
    create_table :server_types do |t|
      t.string :name
      t.timestamps
    end
    ServerType.create(:name=>"db")
    ServerType.create(:name=>"web")
    ServerType.create(:name=>"game")
    ServerType.create(:name=>"all")
    ServerType.create(:name=>"content")
  end

  def self.down
    drop_table :server_types
  end
end
