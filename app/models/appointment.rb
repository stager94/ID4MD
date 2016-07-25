class Appointment < ApplicationRecord

	include Chat::Objectable

	belongs_to :medical_profile

	scope :following, ->{ where "date >= ?", Date.today }

	def build_chat_message
  	I18n.t "chat.custom_messages.appointment", date: self.human_date, text: self.text
  end

  def human_date
  	Russian::strftime date, "%d %B"
  end

end
