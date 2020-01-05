class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  # render a form to create a new recipe
  get "/recipes/new" do
    erb :"recipes/new"
  end
  
  # create and save this new recipe to the database
  # redirects to the recipe show page
  post '/recipes' do 
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end
  
  # uses RESTful routes to display a single recipe
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :"recipes/show"
  end

  # uses RESTful routes and renders a form to edit a single recipe
  get "/recipes/:id/edit" do  #load edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :"recipes/edit"
  end
   
  patch '/recipes/:id' do #edit action
    @recipe = Article.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end
  
  # index action that displays all the recipes in the database
  get '/recipes' do 
    erb :index
  end
  
  # deletes the entry from the database and redirects to the index page
  delete '/recipes/:id' do #delete action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end
end