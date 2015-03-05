class RepositoriesController < ApplicationController

  def index
  end

  def show
    @profile = Profile.decide_which_one(params[:username])
    redirect_to root_path unless @profile
    RepositoryList.new(params[:username])
  end

end
