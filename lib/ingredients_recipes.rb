class Ingredients_recipe < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe
end
