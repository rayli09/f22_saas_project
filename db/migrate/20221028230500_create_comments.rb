class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string :content
      t.references :event
      t.references :user
    end
  end

  def down
    drop_table :comments
  end
end
