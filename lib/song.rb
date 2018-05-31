class Song
  attr_accessor :name
  attr_reader :artist, :genre


  @@all = []

  def initialize(name, artist_object = nil, genre_object = nil)
    @name = name
    self.artist=(artist_object)
    self.genre = (genre_object)
  end

  def artist=(artist_obj)
    @artist = artist_obj
    artist_obj.add_song(self) unless @artist.nil?
  end

  def genre=(genre_obj)
    @genre = genre_obj
    unless @genre == nil || @genre.songs.include?(self)

      @genre.songs << self
    end

  end

  def self.create(song_title)

    song = Song.new(song_title)
    self.all << song
    song
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.find_by_name(song_name)
    self.all.find{|song| song.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    if self.find_by_name(song_name) == nil
      self.create(song_name)
    else
      self.find_by_name(song_name)
    end
  end

  def self.new_from_filename(filename)
    song_title = filename.split(" - ")[1].strip
    artist_name = filename.split(" - ")[0].strip
    genre = filename.split(" - ")[2]
    correct_genre = genre.slice(0,genre.length - 4).strip

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(correct_genre)
    song = Song.new(song_title, artist, genre)

  end

  def self.create_from_filename(filename)
    self.all << self.new_from_filename(filename)
  end



end
