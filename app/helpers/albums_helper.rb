module AlbumsHelper
  def dump_albums(user)
    albums_arr = []
    user.albums.all.each do |a|
      a_hash = {
          id: a.id,
          title: a.title,
          artist: a.artist,
          year: a.year
      }

      albums_arr.append(a_hash)
    end

    albums_arr
  end
end
