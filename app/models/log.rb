class Log < ApplicationRecord
  belongs_to :student
  belongs_to :user


  def self.search(search)  
    where("created_at >= :search1 and created_at <= :search2   ", search1: "#{search}  00:00:00.000",search2: "#{search} 23:59:59.997")  
  end
end
