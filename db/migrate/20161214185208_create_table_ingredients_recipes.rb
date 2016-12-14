class CreateTableIngredientsRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table(:ingredients_recipes) do |i|
      i.column(:ingredient_id, :integer)
      i.column(:recipe_id, :integer)
      i.column(:quantity, :string)
      i.timestamps
    end
  end
end
