class Parent < ApplicationRecord
  belongs_to :user
  belongs_to :student
  # has_and_belongs_to_many :student, join_table: "students", foreign_key: "student_id"
  # has_many :students, class_name: "student", foreign_key: "student_id"
  
  def self.search(search)  
    where("sid LIKE :search ", search: "%#{search}%")  
  end
end
