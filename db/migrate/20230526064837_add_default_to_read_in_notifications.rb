class AddDefaultToReadInNotifications < ActiveRecord::Migration[7.0]
  def change
    change_column_default :notifications, :read, from: nil, to: false
  end
end
