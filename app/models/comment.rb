class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  before_save :adjust_visitor_name

  validates :visitor_name, presence: true, if: 'user.nil?'
  validates :content, presence: true
  validates :post, presence: true

  # default_scope { order('created_at DESC') }

  private
  def adjust_visitor_name
    if self.user.nil? && not(self.visitor_name.blank?)
      self.visitor_name = "Visitante: #{visitor_name}"
    end
  end
end
