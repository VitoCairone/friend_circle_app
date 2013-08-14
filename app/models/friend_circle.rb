class FriendCircle < ActiveRecord::Base
  attr_accessible :name, :owner_id

  has_many :memberships
  has_many :members, :through => :memberships, :source => :user
  belongs_to :owner,
    :class_name => "User",
    :foreign_key => :owner_id
  has_many :post_shares,
    :class_name => "PostShare",
    :foreign_key => :friend_circle_id
  has_many :posts, :through => :post_shares

end
