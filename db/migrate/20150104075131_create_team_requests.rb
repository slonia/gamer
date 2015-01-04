class CreateTeamRequests < ActiveRecord::Migration
  def change
    create_table :team_requests do |t|
      t.references :team, index: true
      t.references :user, index: true
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :team_requests, :teams
    add_foreign_key :team_requests, :users
  end
end
