class AddFieldsForIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :image_url, :string
    add_column :identities, :name, :string
  end
end
