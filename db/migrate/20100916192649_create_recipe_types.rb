class CreateRecipeTypes < ActiveRecord::Migration
  def self.up
      create_table :recipe_types do |t|
      t.integer :recipe_id
      t.integer :server_type_id
      t.timestamps
    end
    RecipeType.create(
    :recipe=>Recipe.find_by_name("status"), 
    :server_type=>ServerType.find_by_name("all"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("server"), 
    :server_type=>ServerType.find_by_name("all"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("serverreport"), 
    :server_type=>ServerType.find_by_name("all"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("restartserver"), 
    :server_type=>ServerType.find_by_name("game"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("restartserver"), 
    :server_type=>ServerType.find_by_name("web"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("restartserver"), 
    :server_type=>ServerType.find_by_name("db"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("restartwebserver"), 
    :server_type=>ServerType.find_by_name("web"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("db"), 
    :server_type=>ServerType.find_by_name("db"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("dbbackup"), 
    :server_type=>ServerType.find_by_name("db"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("statusslave"), 
    :server_type=>ServerType.find_by_name("db"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("startslave"), 
    :server_type=>ServerType.find_by_name("db"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("stopslave"), 
    :server_type=>ServerType.find_by_name("db"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("fillslave"), 
    :server_type=>ServerType.find_by_name("db"))
    
    RecipeType.create(
    :recipe=>Recipe.find_by_name("cdndeploy"), 
    :server_type=>ServerType.find_by_name("content"))
  end

  def self.down
    drop_table :recipe_types
  end
end
