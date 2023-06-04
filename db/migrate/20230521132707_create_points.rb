class CreatePoints < ActiveRecord::Migration[7.0]
  def change
    create_table :points do |t|
      t.integer :point
      t.integer :user_id

      t.timestamps
    end
  end
end
