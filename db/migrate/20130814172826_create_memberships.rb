class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :friend_circle_id
      t.integer :user_id

      t.timestamps
    end
    add_index :memberships, :friend_circle_id
    add_index :memberships, :user_id
  end
end
