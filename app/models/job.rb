class Job < ApplicationRecord
  belongs_to :doctor

  def full_address
  	[self.address, self.name].join ", "
  end
end
