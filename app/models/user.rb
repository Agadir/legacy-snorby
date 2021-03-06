class User < ActiveRecord::Base
  acts_as_authentic
  has_many :comments, :dependent => :destroy
  has_many :importance, :dependent => :destroy


  def self.who_accepts_email
    emails = []
    self.all.each do |user|
      emails << user.email if user.accept_email
    end
    return emails
  end
  
  
  def self.is_admin_or_owner(user, comment_id=nil)
    comment = Comment.find(comment_id)
    if user.admin?
      return true
    elsif user == comment.user
      return true
    else
      false
    end
  end
  
end
