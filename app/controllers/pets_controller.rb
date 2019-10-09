class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params["pet"])

    if !params["owner"]["name"].empty?
      owner = Owner.create(name:params["owner"]["name"])
      owner.pets << @pet
    elsif !!params["pet"]["owner_id"] #allows for ther to be NO OWNER
      owner = Owner.find_by(id:params["pet"]["owner_id"])
      owner.pets << @pet
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    current_pet
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    current_pet
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    if !params[:pet].keys.include?("owner_id")
      params[:owner]["owner_id"] = ""
    end

    current_pet

    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name:params["owner"]["name"])
      @owner.pets << @pet
    end

    redirect to "pets/#{@pet.id}"
  end


  helpers do
    def current_pet
      @pet = Pet.find(params[:id])
    end
  end

end