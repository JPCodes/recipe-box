class Ingredient < ActiveRecord::Base
  has_many :recipes, through: => :ingredients_recipes
  validates_uniqueness_of :name
end
