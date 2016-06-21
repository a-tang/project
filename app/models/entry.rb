class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user

  validates_inclusion_of :entered, :in => [true, false]
  validates :user_id, uniqueness: {scope: :contest_id}

  scope :up_count, -> { where(entered: true).count }

  def self.down_count
    where(entered: false).count
  end

end
