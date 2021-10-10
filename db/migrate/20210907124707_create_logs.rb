class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.string :tawaklna_s
      t.string :sid
      t.references :student, null: true, foreign_key: {on_delete: :nullify}
      t.references :user, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
