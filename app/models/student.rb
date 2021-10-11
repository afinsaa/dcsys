class Student < ApplicationRecord
  belongs_to :school
  has_one_attached :qrimage

  Status = [:immune, :exampted,  :incomplete, :exposed, :infected]

  def self.search(search)  
    where("sid LIKE :search ", search: "%#{search}%")  
  end
end
