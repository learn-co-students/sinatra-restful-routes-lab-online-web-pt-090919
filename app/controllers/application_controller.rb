require_relative "../models/recipe"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # INDEX ACTION

  get "/recipes" do 
    @recipes = Recipe.all
    erb :index
  end

  # ===== END OF INDEX ACTION =====

  # CREATE ACTIONS

  get "/recipes/new" do 
    erb :new
  end

  post "/recipes" do 
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  # ===== END OF CREATE ACTIONS =====

  # SHOW ACTIONS

  get "/recipes/:id" do |id|
    @recipe = Recipe.find_by_id(id)
    erb :show
  end

  # ===== END OF SHOW ACTIONS =====

  # UPDATE/EDIT ACTIONS

  get "/recipes/:id/edit" do |id|
    @recipe = Recipe.find_by_id(id)
    erb :edit
  end

  patch "/recipes/:id" do |id|
    @recipe = Recipe.find_by_id(id)
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save 
    redirect "/recipes/#{@recipe.id}"
  end

  # ===== END OF UPDATE/EDIT ACTIONS =====

  # DESTROY/DELETE ACTION

  delete "/recipes/:id" do |id|
    @recipe = Recipe.find_by_id(id)
    @recipe.delete
    redirect "/recipes"
  end

  # ===== END OF DELETE ACTIONS =====

end
