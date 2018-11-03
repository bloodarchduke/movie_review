class AdminController < ApplicationController
  before_action :authorize_admin, only: [:index, :suggest_list]

  def index
    @movies = Movie.paginate(page: params[:page])
  end

  def destroy
    Movie.find(params[:id]).destroy
    flash[:success] = "Movie deleted"
    redirect_to movies_url
  end

  def suggest_list
    @suggested_movies = Movie.where(check: "0").paginate(page: params[:page])
  end

  private

  def authorize_admin
    redirect_to root_path unless (current_user && current_user.role == "admin")
  end
end
