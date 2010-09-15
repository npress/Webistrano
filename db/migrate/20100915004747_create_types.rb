class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.string :name
      t.timestamps
    end
    Type.create(:name=>"db")
    Type.create(:name=>"web")
    Type.create(:name=>"game")
    Type.create(:name=>"all")
    Type.create(:name=>"content")
  end

  def self.down
  end
end
