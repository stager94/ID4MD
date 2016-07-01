class Diagnosis < ApplicationRecord
  belongs_to :medical_profile

  scope :following, ->{ where "date >= ?", Date.today }
end
