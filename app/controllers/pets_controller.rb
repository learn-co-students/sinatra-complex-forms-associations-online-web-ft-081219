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
    p params 
    if params.keys.include?("pet") 
    
       @pet = Pet.create(name: params["pet_name"])
      @owner = Owner.find(params["pet"]["owner_id"]) 
      @owner.pets << @pet
      redirect to "pets/#{@pet.id}"
    else 
     
      @pet = Pet.create(name: params["pet_name"]) 
      @owner = Owner.create(name: params["owner_name"]) 
      @owner.pets << @pet
      redirect to "pets/#{@pet.id}"
      
    end

  end


  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    p params
      @pet = Pet.find(params["id"])
    if params["owner"]["name"]== ""
      @pet.update(name: params["pet_name"], owner_id: params["pet"]["owner_id"])
      redirect to "pets/#{@pet.id}"
    else
      @owner = Owner.create(name: params["owner"]["name"])
      @owner.pets << @pet
      # @pet.update(name: params["pet_name"], owner_id: @owner.id)
      
      redirect to "pets/#{@pet.id}"
      
    end
  end
end