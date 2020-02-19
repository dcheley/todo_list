class CreateInitialTables < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.timestamps
    end

    create_table :to_dos do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.integer :status, default: 0
      t.timestamps
    end

    add_reference :to_dos, :user, foreign_key: true
  end
end
