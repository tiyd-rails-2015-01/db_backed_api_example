class RepositoryList
  attr_reader :repositories

  def initialize(username)
    results = HTTParty.get(
        "https://api.github.com/users/#{username}/repos?sort=updated",
        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
                     "User-Agent" => "anyone"
                    }
    )
    @repositories = results.map {|r| Repository.create_from_api(username, r)}
  end

end
