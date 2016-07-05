class MedicalProfile < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  
  has_many :diagnosises, class_name: "Diagnosis", dependent: :destroy
  has_many :visits, dependent: :destroy
  has_many :appointments, dependent: :destroy

  validates_presence_of :diagnosis

  scope :by_doctor, ->(id) { where doctor_id: id }

  def to_s
  	[patient.email, doctor.email].join " from "
  end
end
