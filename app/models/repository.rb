class Repository < ActiveRecord::Base
  belongs_to :profile

  def stale?
    self.updated_at < Time.now - 2.seconds
  end

end
