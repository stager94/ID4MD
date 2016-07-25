class Diagnosis < ApplicationRecord

	include Chat::Objectable
	
  belongs_to :medical_profile

  scope :following, ->{ where "date >= ?", Date.today }

  def build_chat_message
  	I18n.t "chat.custom_messages.diagnosis", date: self.human_date, laboratory: self.laboratory, address: self.address
  end

  def human_date
  	Russian::strftime date, "%d %B"
  end
end
