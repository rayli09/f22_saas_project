class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string :title
      t.string :host
      t.string :rating
      t.string :joined
      t.text   :people
      t.integer :status # enum type, 0: open, 1: closed
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
