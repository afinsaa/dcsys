class Student < ApplicationRecord
  belongs_to :school
  
  # has_one :user, through: :parent, source: :student_id
  
  
  has_one_attached :photo
  has_one_attached :qrimage

  has_one :user, through: :parent, source: :user_id

  Status = [:vaild, :canceled, :latepay ]


  validates :sid, uniqueness: { scope: [:school_id] }, :presence => true, numericality: { only_integer: true }



  def self.search(search)  
    where("sid LIKE :search ", search: "%#{search}%")  
  end
end
