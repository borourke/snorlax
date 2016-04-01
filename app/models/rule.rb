class Rule < ActiveRecord::Base
  belongs_to :project

  def self.operators
    ["exists?", "includes", ">", "<", "=", "!=", ">=", "<="]
  end

  def unit_passes?(unit_data)
    unit_data.each do |data|
      if data.field == self.field
        return passes_comparison?(data)
      end
    end
  end

  def passes_comparison?(data)
    puts data.attributes
    puts self.operation
    puts self.value
    data.value.send(self.operation, self.value)
  end
end