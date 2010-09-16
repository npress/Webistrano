class ServerType < ActiveRecord::Base
  has_many :host_types
  has_many :hosts, :through=>:host_types
  has_many :recipe_types
  has_many :recipes, :through => :recipe_types
end
