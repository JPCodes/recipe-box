require 'spec_helper'

describe(Ingredient) do
  describe('') do
    it('adds quantity to an ingredient') do
      test_recipe = Recipe.create({:name => 'Steak', :instructions => 'Throw it on the grill', :rating => 8})
      test_ingredient = Ingredient.create({:name => 'lean beef'})
      test_quantity = Ingredients_recipe.create({:recipe_id => test_recipe.id, :ingredient_id => test_ingredient.id, :quantity => "1"})
      expect(test_quantity.quantity).to(eq("1"))
    end
  end

  describe('') do
    it('updates correct ingredients_recipes entry') do

      test_recipe = Recipe.create({:name => 'Steak', :instructions => 'Throw it on the grill', :rating => 8})
      test_ingredient = Ingredient.create({:name => 'lean beef'})
      test_quantity = Ingredients_recipe.create({:recipe_id => test_recipe.id, :ingredient_id => test_ingredient.id, :quantity => nil})
      test_quantity = Ingredients_recipe.where(recipe_id: test_recipe.id)

      test_recipe2 = Recipe.create({:name => 'Steak', :instructions => 'Throw it on the grill', :rating => 8})
      test_ingredient2 = Ingredient.create({:name => 'lean beef'})
      test_quantity2 = Ingredients_recipe.create({:recipe_id => test_recipe.id, :ingredient_id => test_ingredient.id, :quantity => nil})

      test_quantity.update({:quantity => "2"})

      expect(test_quantity.first().quantity).to(eq("2"))
    end
  end
end
