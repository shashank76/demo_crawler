class CreateDeletedNews < ActiveRecord::Migration[5.2]
  def change
    create_table :deleted_news do |t|
      t.references :user, foreign_key: true
      t.references :news, foreign_key: true

      t.timestamps
    end
  end
end
