class AddDatabaseToRepository < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.column :body, :text
      t.column :name, :string
      t.column :repo_url, :string
      t.column :number_of_forks, :integer
      t.column :number_of_stars, :integer
      t.column :last_modified_at, :datetime
      t.column :language, :string
      t.column :profile_id, :integer
    end
  end
end
