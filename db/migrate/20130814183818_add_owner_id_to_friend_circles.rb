class AddOwnerIdToFriendCircles < ActiveRecord::Migration
  def change
    add_column :friend_circles, :owner_id, :integer
    add_index :friend_circles, :owner_id
  end
end
