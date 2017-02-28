# -*- encoding : utf-8 -*-
class Api::V1::PrincipalcategoriesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!

 def index
  	data = []
  	json = {}
  	categorias = []
  	principalcategory = Principalcategory.all()
  	principalcategory.each do |category|
  		pcategories = {}
  		subcategories = []
  		pcategories[:id] = category[:id] 
  		pcategories[:name] = category[:name]
  		aux = SecundaryCategory.where('principalcategory_id = ?', category[:id])
  		aux.each do |subcat|
  			auxiliar = {}
  			auxiliar[:id] = subcat[:id] 
        auxiliar[:name] = subcat[:name]
  			auxiliar[:id_principal_category] = category[:id]
  			auxiliar[:categories] = Category.where('secundary_category_id = ?', subcat[:id])
  			subcategories.push(auxiliar)
  		end
  		pcategories[:subcategories] = subcategories
  		categorias.push(pcategories)
  	end
    data = categorias
    json[:data] = data
    render json: json
  end

end
