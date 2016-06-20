class Patient < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :gender, :phone
  has_many :medical_profiles
  accepts_nested_attributes_for :medical_profiles

  has_attached_file :avatar, styles: { medium: "160x160#", thumb: "60x60#" }, default_url: "/images/patient/:style/missing_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def medical_profile_for(doctor)
  	self.medical_profiles.by_doctor(doctor.id).first
  end
end
