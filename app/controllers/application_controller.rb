class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  
  get "/recipes/new" do
    erb :new
  end
  
  post "/recipes" do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end
  
  get "/recipes/:id" do
    @recipe = Recipe.find_by(params)
    erb :recipe
  end
  
  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by(params)
    erb :edit
  end
  
  patch "/recipes/:id" do
    Recipe.update(params)
    redirect to "/recipes/:id"
  end
  
  delete "/recipes/:id" do
    Recipe.delete(params[:id])
    redirect to "/recipes"
  end
  
  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

end
