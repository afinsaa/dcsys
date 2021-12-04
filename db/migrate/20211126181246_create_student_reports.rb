class CreateStudentReports < ActiveRecord::Migration[6.1]
  def change
    create_table :student_reports do |t|

      t.text :note
      t.string :ntype

      t.references :student, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      # t.references :school, null: false, foreign_key: true
      t.timestamps
    end
  end
end
