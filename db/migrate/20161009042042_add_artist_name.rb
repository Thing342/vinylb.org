class AddArtistName < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :artist, :string
  end
end
