class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  
  post '/recipes' do
  	@recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
  	redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do 
  	@recipe = Recipe.find_by(id: params[:id])
  	erb :'recipes/show'
  end

  get '/recipes/:id/edit' do 
  	@recipe = Recipe.find_by(id: params[:id])
  	erb :'recipes/edit'
  end 

  post '/recipes/:id' do 
  	@recipe = Recipe.find_by(id: params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  post '/recipes/:id/delete' do 
  	@recipe = Recipe.find_by(id: params[:id])
  	@recipe.delete 
  	redirect to '/recipes'
  end

end
