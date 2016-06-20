class MedicalProfile < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  
  # has_many :diagnosises
  has_many :visits
  has_many :appointments

  validates_presence_of :diagnosis

  scope :by_doctor, ->(id) { where doctor_id: id }
end
