class Thought < ActiveRecord::Base
  validates_presence_of :content
  validates_length_of :content, :minimum => 5
end
