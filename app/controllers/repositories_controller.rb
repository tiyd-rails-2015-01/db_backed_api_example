class RepositoriesController < ApplicationController

  def index
  end

  def show
    @profile = Profile.get_by_username(params[:username])
    redirect_to root_path unless @profile
  end

end
