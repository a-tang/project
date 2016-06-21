class Category < ActiveRecord::Base
  validates(:name, {presence: true, uniqueness: {message: "must be unique!"}})
  has_many :contests, dependent: :nullify
end
