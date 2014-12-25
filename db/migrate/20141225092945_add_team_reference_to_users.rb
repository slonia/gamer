class AddTeamReferenceToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :team
    end
  end
end
