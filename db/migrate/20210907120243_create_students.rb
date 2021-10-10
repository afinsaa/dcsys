class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :sid
      t.string :name
      t.string :tawaklna_s
      t.string :qrcode
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
