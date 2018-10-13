class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.string :url
      t.string :title
      t.string :hacker_url
      t.string :posted_on
      t.string :upvotes
      t.string :comments

      t.timestamps
    end
  end
end
