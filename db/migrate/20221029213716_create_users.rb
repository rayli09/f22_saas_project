class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.timestamps null: false
      t.integer :rating, default: 5, null:false
      # number of ratings received for user u
      t.integer :num_rating_got, default: 1, null:false
      # coins are used for promotion
      t.integer :coins, default: 100, null:false
      # privacy control for user profile
      t.boolean :show_email, default: true, null:false
      t.boolean :show_my_events, default: true, null:false
    end
  end
end
