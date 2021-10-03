class School < ApplicationRecord
    has_many :users, class_name: "user", foreign_key: "school_id"
    has_many :students, class_name: "student", foreign_key: "school_id"
end
