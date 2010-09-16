class RecipeType < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :server_type
  validates_uniqueness_of :server_type_id, :scope=>:recipe_id
end
