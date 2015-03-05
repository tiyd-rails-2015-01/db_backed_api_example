class RepositoriesController < ApplicationController

  def index
  end

  def show
    @profile = Profile.find_by_username(params[:username]) ||
      Profile.create_from_username(params[:username])
    redirect_to root_path unless @profile
    RepositoryList.new(params[:username])
  end

end
