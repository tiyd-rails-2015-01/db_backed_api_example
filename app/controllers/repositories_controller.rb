class RepositoriesController < ApplicationController
  def index
    @my_repositories = MyRepositories.new
    @response = HTTParty.get("https://api.github.com/users/tmidge/repos?sort=updated",
         :headers => {
           "Authorization" => "token #{ENV['GITHUB_TOKEN']}",
           "User-Agent" => "tmidge"})
  end
end
