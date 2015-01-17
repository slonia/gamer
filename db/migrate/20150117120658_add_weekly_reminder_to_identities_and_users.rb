class AddWeeklyReminderToIdentitiesAndUsers < ActiveRecord::Migration
  def change
    add_column :identities, :weekly_reminder, :boolean, default: false, null: false
    add_column :users, :weekly_reminder, :boolean, default: false, null: false
  end
end
