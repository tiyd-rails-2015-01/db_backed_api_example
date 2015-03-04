class Profile < ActiveRecord::Base

  def self.create_from_username(username)
    response = HTTParty.get(
        "https://api.github.com/users/#{username}",
        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
                     "User-Agent" => "anyone"
                    }
    )
    if response["login"]
      Profile.create(body: response,
                    username: response["login"],
                    avatar_url: response["avatar_url"],
                    location: response["location"],
                    company_name: response["company"],
                    number_of_followers: response["followers"],
                    number_following: response["following"]
    )

    else
      return nil
    end
  end
end
