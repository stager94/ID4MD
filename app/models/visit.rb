class Visit < ApplicationRecord

	include Chat::Objectable

  belongs_to :medical_profile

  scope :following, ->{ where "date >= ?", Date.today }

end
