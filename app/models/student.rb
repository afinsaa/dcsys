class Student < ApplicationRecord
  belongs_to :school
  has_one_attached :qrimage

  Status = [:immune, :exampted,  :incomplete, :exposed, :infected]


  validates :sid, uniqueness: { scope: [:school_id] }, :presence => true, numericality: { only_integer: true }



  def self.search(search)  
    where("sid LIKE :search ", search: "%#{search}%")  
  end
end
