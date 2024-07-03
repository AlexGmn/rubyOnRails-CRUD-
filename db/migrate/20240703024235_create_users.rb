class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :nombre
      t.string :apellido
      t.string :password_digest
      t.boolean :approved

      t.timestamps
    end
  end
end
