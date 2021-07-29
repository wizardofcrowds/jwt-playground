class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :client_identifier
      t.string :client_secret_digest

      t.timestamps
    end

    add_index :clients, :client_identifier, unique: true
  end
end
