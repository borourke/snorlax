class Rule < ActiveRecord::Base
  belongs_to :project

  def self.operators
    ["exists?", "includes", ">", "<", "=", "!=", ">=", "<="]
  end
end