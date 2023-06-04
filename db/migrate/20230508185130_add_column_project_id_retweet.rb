class AddColumnProjectIdRetweet < ActiveRecord::Migration[7.0]
  def change
    add_reference :projects, :retweeted_project, foreign_key: { to_table: :projects }
  end
end
