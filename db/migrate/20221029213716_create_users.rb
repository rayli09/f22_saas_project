class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.timestamps null: false
      t.integer :rating, default: 5, null:false
      # number of ratings received for user u
      t.integer :num_rating_got, default: 1, null:false
    end
  end
end
