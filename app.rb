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
  @recipe = Recipe.new({:name => name, :instructions => instructions, :rating => rating})
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
  @all_tags = Tag.all
  @ingredients_for_recipe = @recipe.ingredients
  # @quantitys = @recipe.ingredients( )
  erb(:recipe)
end

patch('/recipe_add_tag/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  tag_input = params[:tag_input]
  @new_tag = Tag.new({:name => tag_input})
  if @new_tag.save
    @recipe.tags.push(@new_tag)
    redirect("/recipe/#{@recipe.id}")
  else
    erb(:error)
  end
end

patch('/recipe_add_existing_tag/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  old_new_tag = Tag.find(params[:existing_tag_input].to_i)
  @recipe.tags.push(old_new_tag)
  if !old_new_tag.nil?
    redirect("/recipe/#{@recipe.id}")
  else
    erb(:error)
  end
end

post('/add_ingredient/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  ingredient = params[:new_ingredient]
  new_quantity_input = params[:new_quantity_input]
  @new_ingredient = Ingredient.create({:name => ingredient})
  test_quantity = Ingredients_recipe.create({:recipe_id => @recipe.id, :ingredient_id => @new_ingredient.id, :quantity => new_quantity_input})
  if !@new_ingredient.nil?
    # Caused repeats because we have a join table
    # @recipe.ingredients.push(@new_ingredient)
    redirect("/recipe/#{@recipe.id}")
  else
    erb(:error)
  end
end

delete('/delete_recipe/:id') do
  Recipe.find(params[:id].to_i).destroy
  redirect("/recipes")
end

get('/tag/:id/:id2') do
  @tag = Tag.find(params[:id].to_i)
  @recipe = Recipe.find(params[:id2].to_i)
  erb(:tag_edit)
end

patch('/tag_edit/:id') do
  tag_input = params[:tag_input]
  @tag = Tag.find(params[:id].to_i)
  @tag.update({:name => tag_input})
  erb(:tag_edit)
end

delete('/tag_delete/:id/:id2') do
  @recipe = Recipe.find(params[:id2])
  current_tag = Tag.find(params[:id].to_i)
  # Delete removes the relationship between this tag and recipe
  @recipe.tags.delete(current_tag)
  redirect("/recipe/#{@recipe.id}")
end

get('/recipe/:id/edit') do
  @recipe = Recipe.find(params[:id].to_i)
  erb(:edit_recipe)
end

patch('/edit_instructions/:id') do
  new_instructions = params[:instructions]
  @recipe = Recipe.find(params[:id].to_i)
  @recipe.update({:instructions => new_instructions})
  redirect("/recipe/#{@recipe.id}")
  erb(:recipe)
end

get('/ingredient/:id/:id2') do
  @ingredient = Ingredient.find(params[:id].to_i)
  @recipe = Recipe.find(params[:id2].to_i)
  erb(:ingredient_edit)
end

delete('/ingredient/:id/:id2') do
  @ingredient = Ingredient.find(params[:id].to_i)
  @recipe = Recipe.find(params[:id2].to_i)
  @recipe.ingredients.delete(@ingredient)
  redirect("/recipe/#{@recipe.id}")
end
