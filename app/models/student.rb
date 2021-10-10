class Student < ApplicationRecord
  belongs_to :school
  has_one_attached :qrimage

  Status = [:ammune, :first_dose ,:infected]

  def self.search(search)  
    where("sid LIKE :search ", search: "%#{search}%")  
  end
end
