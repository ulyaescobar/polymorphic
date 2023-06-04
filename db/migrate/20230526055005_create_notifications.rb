class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :actor_id
      t.string :notifiable_type
      t.integer :notifiable_id
      t.string :action
      t.boolean :read

      t.timestamps
    end
  end
end
