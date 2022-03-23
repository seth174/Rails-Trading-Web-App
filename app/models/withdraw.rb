class Withdraw < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true, numericality: { less_than: 0 }

  def self.findAll(user_id, date)
    date = date == "" ? "2000-00-00" : DateTime.now().prev_month(date.to_i)
    Withdraw.where('user_id = ? and created_at > ?', user_id, date).order('created_at DESC')
  end
end
