class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :slug
      t.text :upstream_response

      t.timestamps
    end

    add_index :searches, :slug, unique: true
  end
end
