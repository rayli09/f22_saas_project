class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string :title
      t.string :host
      t.integer :joined
      t.text   :people
      t.integer :status # enum type, 0: open, 1: closed
      t.text :description
      t.datetime :event_time
      t.integer :attendee_limit
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
      t.text :rated_users
      t.boolean :promoted?, default: false
    end
  end

  def down
    drop_table :events
  end
end
