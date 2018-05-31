class Genre
  extend Concerns::Findable
  attr_accessor :name


  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
   artist_collection = self.songs.collect{|song| song.artist}
   artist_collection.uniq
  end

  def songs
    @songs
  end

  def save
    self.class.all << self
  end

  def self.create(title)
    genre = Genre.new(title)
    self.all << genre
    genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end
end
