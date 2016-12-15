class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:tags)
  has_many :ingredients_recipes, :class_name => 'Ingredients_recipe'
  has_many :ingredients, through: :ingredients_recipes
end
