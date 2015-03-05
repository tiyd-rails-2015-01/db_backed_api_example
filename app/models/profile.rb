class Profile < ActiveRecord::Base
  has_many :repositories

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

  def update_from_api
    response = HTTParty.get(
        "https://api.github.com/users/#{self.username}",
        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
                     "User-Agent" => "anyone"
                    }
    )
    if response["login"]
      self.update(body: response,
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

  def need_to_update?
    self.updated_at < 1.minute.ago
  end

  def self.decide_which_one(username)
    p = Profile.find_by_username(username) ||
      Profile.create_from_username(username)

    p.update_from_api if p.need_to_update?
    return p
  end

end
