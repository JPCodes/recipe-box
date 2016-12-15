class Recipe < ActiveRecord::Base
  validates_uniqueness_of :name
  validates :name, :instructions, :rating, presence: true
  has_and_belongs_to_many(:tags)
  has_many :ingredients_recipes, :class_name => 'Ingredients_recipe'
  has_many :ingredients, through: :ingredients_recipes
end
