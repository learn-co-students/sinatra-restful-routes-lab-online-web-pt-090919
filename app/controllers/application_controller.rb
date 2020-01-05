class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  
  post '/recipes' do
    @recipes = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end
  
  get '/recipes/new' do
    erb :new
  end
  
  get '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    erb :show
    
  end

  get '/recipes/:id/edit' do
    @recipes = Recipe.find_by_id(params[:id])
    erb:edit
  end
  
  patch '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.name = params[:name]
    @recipes.ingredients = params[:ingredients]
    @recipes.cook_time = params[:cook_time]
    @recipes.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.delete
    redirect to '/recipes'
  end
end
