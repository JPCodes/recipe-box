ENV['RACK_ENV'] = 'test'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require("bundler/setup")
Bundler.require(:default, :test)

RSpec.configure do |config|
  config.after(:each) do
    Ingredient.all().each do |ingredient|
      ingredient.destroy()
    end
    Recipe.all().each do |recipe|
      recipe.destroy()
    end
    Tag.all().each do |tag|
      tag.destroy()
    end
  end
end
