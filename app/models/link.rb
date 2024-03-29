class Link < ActiveRecord::Base
  attr_accessible :name, :post_id, :url

  belongs_to :post, :inverse_of => :links
end
