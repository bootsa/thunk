class Thought < ActiveRecord::Base
  validates_presence_of :thought
  validates_length_of :thought, :minimum => 5
end
