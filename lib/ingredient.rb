class Ingredient < ActiveRecord::Base
  has_many :ingredients_recipes, :class_name => 'Ingredients_recipe'
  has_many :recipes, through: :ingredients_recipes
  # validates_uniqueness_of :name
end
