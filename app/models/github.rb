class Github
  def self.profile_for(username)
    response = HTTParty.get("https://api.github.com/users/#{username}",
        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
                     "User-Agent" => "anyone"})

    return nil if response.code == 404

    { body: response,
        username: response["login"],
        avatar_url: response["avatar_url"],
        location: response["location"],
        company_name: response["company"],
        number_of_followers: response["followers"],
        number_following: response["following"] }
  end

  def self.repositories_for(username)
    response = HTTParty.get(
        "https://api.github.com/users/#{username}/repos?sort=updated",
        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
                     "User-Agent" => "anyone"})

    response.map do |r|
      {body: r,
          name: r["name"],
          repo_url: r["url"],
          number_of_forks: r["forks_count"],
          number_of_stars: r["stargazers_count"],
          last_modified_at: r["updated_at"],
          language: r["language"] }
    end
  end
end
