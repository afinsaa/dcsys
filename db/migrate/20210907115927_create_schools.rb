class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :contact_name
      t.string :phone
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end
end
