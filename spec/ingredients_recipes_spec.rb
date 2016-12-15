require 'spec_helper'

describe(Ingredients_recipe) do
  describe('') do
    it('adds an ingredient to a recipe') do
      test_recipe = Recipe.create({:name => 'Steak', :instructions => 'Throw it on the grill', :rating => 8})
      test_ingredient = Ingredient.create({:name => 'lean beef'})
      test_join = Ingredients_recipe.create({:recipe_id => test_recipe.id, :ingredient_id => test_ingredient.id, :quantity => "1"})
      test_recipe.ingredients.push(test_ingredient)
      expect(test_recipe.ingredients.first()).to(eq(test_ingredient))
    end
  end

end
