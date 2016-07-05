class Doctor < ActiveRecord::Base

  include Authenticable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :medical_profiles

  def name
  	[last_name, first_name].join " "
  end

  def to_s
  	email
  end

end
