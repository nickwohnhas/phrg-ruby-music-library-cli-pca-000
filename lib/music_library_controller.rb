require 'pry'
class MusicLibraryController
  attr_accessor :input
  def initialize(path = './db/mp3s')
    @path = path
    @music_importer = MusicImporter.new(@path)
    @music_importer.import
  end

  def call
    welcome_text
    input = gets.chomp
    unless input == 'exit'
        if input == 'list songs'
          list_songs
        elsif input == 'list artists'
          list_artists
        elsif input == 'list genres'
          list_genres
        elsif input == 'list artist'
          list_songs_by_artist
        elsif input == 'list genre'
          list_songs_by_genre
        elsif input == 'play song'
          play_song
        else
          call
        end
      end
  end

  def list_songs
    organized_array.each_with_index do |song_string, index|
      puts "#{index + 1}. #{song_string.gsub(".mp3","")}"
    end
  end

  def organized_array
    @music_importer.files.sort do |a,b|
      a.split("-")[1] <=> b.split("-")[1]
    end
  end

  def list_artists
    sorted_artist_object_array = Artist.all.sort{|a,b| a.name <=> b.name}
    sorted_artist_object_array.each_with_index do |value, index|
      puts "#{index + 1}. #{value.name}"
    end
  end

  def welcome_text
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
  end

  def list_genres
#   sorted_genre_object_array = Genre.all.sort{|a,b| a.name <=> b.name}
# sorted_genre_object_array.each_with_index{|e,i| puts "#{i + 1}. "}
 # empty_array = []
 # Genre.all.each do |element|
 #  empty_array << element.name

 #  end

 #  empty_array.shift
 #  empty_array.each_with_index{|e,i| puts "#{i + 1}. #{e}"}
organized_array = @music_importer.files.sort{|a,b| a.split("-")[2] <=> b.split("-")[2]}
  a = organized_array.collect{|song_string| song_string.split(" - ")[2].gsub(".mp3","")}
  a.uniq.each_with_index{|e,i| puts "#{i + 1}. #{e}"}

end

def list_songs_by_artist
  puts "Please enter the name of an artist:"
  artist_name = gets.chomp
  artist_object = Artist.find_by_name(artist_name)
    unless artist_object === nil
    organized_array = artist_object.songs.sort{|a,b| a.name <=> b.name}
      organized_array.each_with_index do |e, i|
    puts "#{i + 1}. #{e.name} - #{e.genre.name}"
    end
  end
end

def list_songs_by_genre
  puts "Please enter the name of a genre:"
  genre_name = gets.chomp
  genre_object = Genre.find_by_name(genre_name)

unless genre_object == nil
organized_array = genre_object.songs.sort{|a,b| a.name <=> b.name}
      organized_array.each_with_index do |e, i|
        puts "#{i + 1}. #{e.artist.name} - #{e.name}"
      end
end
end

def play_song
  puts 'Which song number would you like to play?'
  song_num = gets.chomp
  int = song_num.to_i
  if int.between?(1, organized_array.length)
    song_string = organized_array[song_num.to_i - 1]
    artist = song_string.split(' - ')[0].strip
    song_title = song_string.split(' - ')[1].strip
    puts "Playing #{song_title} by #{artist}"
  end
end
end
