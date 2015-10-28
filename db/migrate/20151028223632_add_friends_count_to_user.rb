class AddFriendsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :friends_count, :string
  end
end
