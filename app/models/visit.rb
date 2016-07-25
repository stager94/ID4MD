class Visit < ApplicationRecord

	include Chat::Objectable

	belongs_to :medical_profile

	scope :following, ->{ where "date >= ?", Date.today }

	validates_presence_of :date

	def build_chat_message
		I18n.t "chat.custom_messages.visit", date: self.human_date, address: self.address
	end

	def human_date
		Russian::strftime date, "%d %B"
	end

end
