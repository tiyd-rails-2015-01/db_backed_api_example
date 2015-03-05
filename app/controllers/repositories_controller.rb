class RepositoriesController < ApplicationController

  def index
  end

  def show
    @profile = Profile.find_by_username(params[:username]) ||
      Profile.create_from_username(params[:username])
    RepositoryList.new(params[:username])
  end

end
