class Task < ActiveRecord::Base
  validates_presence_of :content, :list_id
  belongs_to :list
end
