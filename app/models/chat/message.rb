class Chat::Message < ApplicationRecord
	include PdmApp::Chat::Constants

  belongs_to :medical_profile

  belongs_to :objectable, polymorphic: true
  belongs_to :sender, polymorphic: true

  validates_presence_of :sender, :medical_profile

  scope :for_medical_profile, ->(medical_profile_id) { order(created_at: :desc).where medical_profile_id: medical_profile_id }

  def type
  	self.objectable_type.to_s.downcase
  end

  def date
  	Russian::strftime self.created_at, "%A %d %B %Y"
  end
end
