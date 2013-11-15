class MyValidator < ActiveModel::Validator
  def validate(contest)
    if contest.start && contest.deadline && contest.deadline > contest.start
      contest.errors.add(:deadline, "Deadline cannot be after start")
    end
    if contest.start && contest.deadline && contest.deadline < DateTime.now.change(:usec => 0)
      contest.errors.add(:deadline, "Deadline cannot be before now (present time)")
    end 
    if contest.start && contest.deadline && contest.start < DateTime.now.change(:usec => 0)
      contest.errors.add(:start, "Start cannot be before now (present time)")
    end
  end

end

class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee
  has_many :players
  has_many :matches, as: :manager
  validates :referee, presence: true
  validates :user, presence: true
  
  validates :name, presence: true, uniqueness: true
  validates :contest_type, presence: true
  validates :start, presence: true 
  validates :deadline, presence: true
  validates :description, presence: true
  
  include ActiveModel::Validations
  validates_with MyValidator
  
end