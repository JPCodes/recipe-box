require("bundler/setup")
require("pry")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all
  erb(:recipes)
end

post('/recipe_add') do
  name = params[:recipe_name]
  instructions = params[:instructions]
  rating = params[:rating].to_i
  tag_input = params[:tag_input]
  @tag = Tag.create({:name => tag_input})
  @recipe = Recipe.create({:name => name, :instructions => instructions, :rating => rating})
  @recipe.tags.push(@tag)
  if @recipe.save
    redirect("/recipe/#{@recipe.id}")
  else
    erb(:error)
  end
end

get('/recipe/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  @tags = @recipe.tags
  @ingredients_for_recipe = @recipe.ingredients
  puts @recipe.ingredients.inspect
  erb(:recipe)
end

patch('/recipe_add_tag/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  tag_input = params[:tag_input]
  new_tag = Tag.create({:name => tag_input})
  @recipe.tags.push(new_tag)
  if new_tag.save
    redirect("/recipe/#{@recipe.id}")
  else
    erb(:error)
  end
end

post('/add_ingredient/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  ingredient = params[:new_ingredient]
  new_quantity_input = params[:new_quantity_input]
  new_ingredient = Ingredient.new({:name => ingredient})
  test_quantity = Ingredients_recipe.create({:recipe_id => @recipe.id, :ingredient_id => new_ingredient.id, :quantity => new_quantity_input})
  # binding.pry
  @recipe.ingredients.push(new_ingredient)
  if !test_quantity.nil?
    redirect("/recipe/#{@recipe.id}")
  else
    erb(:error)
  end
end

delete('/delete_recipe/:id') do
  Recipe.find(params[:id].to_i).destroy
  redirect("/recipes")
end
