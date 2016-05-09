class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.datetime :open_time
      t.datetime :close_time

      t.timestamps
    end
  end
end
