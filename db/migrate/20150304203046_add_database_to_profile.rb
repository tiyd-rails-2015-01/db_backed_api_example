class AddDatabaseToProfile < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.column :body, :text
      t.column :username, :string
      t.column :avatar_url, :string
      t.column :location, :string
      t.column :company_name, :string
      t.column :number_of_followers, :integer
      t.column :number_following, :integer
    end
  end
end
