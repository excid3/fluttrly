class List < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :tasks
  belongs_to :user
end
