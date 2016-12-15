require 'spec_helper'

describe(Recipe) do
  describe('#') do
    it "Adds a tag to a recipe" do
      test_recipe = Recipe.create({:name => 'Brownies', :instructions => 'Bake at 350 F for 25 minutes', :rating => 5})
      test_tag = Tag.create({:name => 'Dessert'})
      test_recipe.tags.push(test_tag)
      expect(test_recipe.tags).to(eq([test_tag]))
    end
  end

  it("validates presence of description") do
    recipe = Recipe.new({:name => ""})
    expect(recipe.save()).to(eq(false))
  end

end
