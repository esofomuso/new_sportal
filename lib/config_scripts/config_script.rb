class ConfigScript
  def initialize
    self.send(ARGV[0])
  end
  
  def up
    ActiveRecord::Base.transaction do
      self.bring_up
      Rails.cache.clear
    end
  end

  def down
    ActiveRecord::Base.transaction do
      self.bring_down
      Rails.cache.clear
    end
  end
end