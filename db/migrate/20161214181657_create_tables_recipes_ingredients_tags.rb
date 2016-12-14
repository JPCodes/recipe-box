class CreateTablesRecipesIngredientsTags < ActiveRecord::Migration[5.0]
  def change
    create_table(:recipes) do |r|
      r.column(:name, :string)
      r.column(:instructions, :text)
      r.column(:rating, :integer)

      r.timestamps()
    end
    create_table(:tags) do |t|
      t.column(:name, :string)
    end
    create_table(:ingredients) do |i|
      i.column(:name, :string)
    end
  end
end
