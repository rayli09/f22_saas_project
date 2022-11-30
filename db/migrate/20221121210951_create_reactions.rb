class CreateReactions < ActiveRecord::Migration
  def up
    create_table :reactions do |t|
      t.integer :action
      t.references :comment
      t.references :user
    end
  end

  def down
    drop_table :reactions
  end
end
