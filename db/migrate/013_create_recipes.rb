class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :body, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :role_needed, :boolean, :default=>true
    end
    
    
  end

  def self.down
    drop_table :recipes
    
  end
end
