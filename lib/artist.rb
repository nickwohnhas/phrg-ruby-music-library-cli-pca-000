class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
  genre_collection = self.songs.collect{|song| song.genre}
  genre_collection.uniq
  end

  def songs
    @songs
  end

  def add_song(song)
    unless song.artist
      song.artist=(self)
    end

    if !(songs.include?(song))
      self.songs << song
    end
  end

  def save
    self.class.all << self
  end

  def self.create(title)
    artist = Artist.new(title)
    self.all << artist
    artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end
end
