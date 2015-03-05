class Repository < ActiveRecord::Base
  belongs_to :profile

  def self.create_from_api(username, hash)
      profile = Profile.find_by(username: username)
      return if profile.nil?
      r = Repository.where(github_id: hash["id"])
      #TERRIBLE BC WHAT IF YOU CHANGE THE NAME
      return if r.count > 0

      # (Repository.find_by(name: hash["name"])) && (Repository.find_by(profile_id: profile.id))



      Repository.create(body: hash,
                    github_id: hash["id"],
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
