class ToDo < ApplicationRecord
  validates :title, :status, :due_date, :description, presence: true
  validates_length_of :description, maximum: 150

  belongs_to :user

  scope :pending, -> { where(status: 0) }
  scope :done, -> { where(status: 1) }

  def self.search(search)
    where("title ILIKE ?", "%#{search}%")
  end

  # For Simple Calendar gem
  def start_time
    self.due_date
  end
end
