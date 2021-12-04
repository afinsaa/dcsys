class StudentReport < ApplicationRecord
  

  belongs_to :student
  has_one_attached :attachment

  Status = [:note, :alert,  :reminder]


  # validates :sid, uniqueness: { scope: [:school_id] }, :presence => true, numericality: { only_integer: true }



  def self.search(search)  
    where("sid LIKE :search ", search: "%#{search}%")  
  end

end
