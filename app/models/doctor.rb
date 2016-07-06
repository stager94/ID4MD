class Doctor < ActiveRecord::Base

  include Member::Authenticable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  validates_uniqueness_of :phone
  validates_presence_of :phone
  
  has_many :medical_profiles
  has_many :jobs

  def name
  	[last_name, first_name].join " "
  end

  def to_s
  	email
  end

end
