class Post < ActiveRecord::Base
  attr_accessible :body, :title, :user_id, :links_attributes

  has_many :links, :inverse_of => :post
  belongs_to :user, :inverse_of => :posts
  has_many :post_shares, :inverse_of => :posts
  has_many :friend_circles, :through => :post_shares

  accepts_nested_attributes_for :links, :reject_if => :all_blank

end
