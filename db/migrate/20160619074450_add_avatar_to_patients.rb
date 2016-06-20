class AddAvatarToPatients < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :patients, :avatar
  end
end
