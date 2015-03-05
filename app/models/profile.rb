class Profile < ActiveRecord::Base
  has_many :repositories

  def self.get_by_username(username)
    profile = find_by_username(username)
    if profile.blank?
      if github_profile = Github.profile_for(username)
        profile = create(github_profile)
      end
    end

    profile.refresh if profile

    profile
  end

  def refresh
    update_from_github if stale?
    update_repositories_from_github if stale_repositories?
  end

  def stale?
    self.updated_at < Time.now - 1.day
  end

  def stale_repositories?
    repositories.blank? || repositories.any? {|r| r.stale?}
  end

  def update_from_github
    update(Github.profile_for(username))
  end

  def update_repositories_from_github
    repositories.destroy_all
    Github.repositories_for(username).each do |r|
      repositories << Repository.create(r)
    end
  end

end
