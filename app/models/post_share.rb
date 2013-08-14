class PostShare < ActiveRecord::Base
  attr_accessible :friend_circle_id, :post_id

  belongs_to :friend_circle
  belongs_to :post

end
