class Repository < ActiveRecord::Base
  belongs_to :profile

  def self.create_from_api(username, hash)
      profile = Profile.find_by(username: username)
      r = Repository.where(name: hash["name"], profile_id: profile.id)
      return if r.count > 0 

      # (Repository.find_by(name: hash["name"])) && (Repository.find_by(profile_id: profile.id))



      Repository.create(body: hash,
                    name: hash["name"],
                    repo_url: hash["url"],
                    number_of_forks: hash["forks_count"],
                    number_of_stars: hash["stargazers_count"],
                    last_modified_at: hash["updated_at"],
                    language: hash["language"],
                    profile_id: profile.id
    )
  end

end
