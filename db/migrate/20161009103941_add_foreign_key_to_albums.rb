class AddForeignKeyToAlbums < ActiveRecord::Migration[5.0]
  def change
    add_reference :albums, :user, index: true
  end
end
