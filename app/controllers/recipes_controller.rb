class RecipesController < ApplicationController
  def root
  end

  def search
    recipes = EdemamWrapper.search_recipes(params[:search_term])
    redirect_to index_path(search_term: params[:search_term])

  end

  def index
    search_term = params[:search_term]
    @recipes = EdemamWrapper.search_recipes(search_term).paginate(:page => params[:page], :per_page => 12)
    if !@recipes
      flash.now[:error] = "There are no recipes matching this query. Please try again."
      render :root
    end
    # raise
  end

  def show
    @recipe = EdemamWrapper.show_recipe(params[:format])
    if !@recipe
      flash.now[:error] = "This recipe does not exist. Please try again."
      render root_path
    end
  end

end
