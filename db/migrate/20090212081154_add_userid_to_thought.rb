class AddUseridToThought < ActiveRecord::Migration
  def self.up
    add_column :thoughts, :user_id, :integer, :options => "CONSTRAINT fk_thought_user REFERENCES user(id)"
  end

  def self.down
    remove_column :thoughts, :user_id
  end
end
