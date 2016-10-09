module ApplicationHelper
  LASTFM_KEY = 'c5a87ea37f36c026178c045ce545f500'
  LASTFM_SECRET = '9ae167753d5022ad57cc95b660ba5106'

  def album_image(album)
    return album.image unless album.image.nil?

    url = URI.parse "http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=c5a87ea37f36c026178c045ce545f500&artist=#{album.artist}&album=#{album.title}"
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    xml = Hash.from_xml(res.body.to_s)

    puts xml
    return 'default.png' if xml['lfm']['status'] == 'failed'

    image = xml['lfm']['album']['image'][1]
    album.image = image
    album.save
    image
  end

end
