class Appointment < ApplicationRecord
	belongs_to :medical_profle

	scope :following, ->{ where "date >= ?", Date.today }
end
