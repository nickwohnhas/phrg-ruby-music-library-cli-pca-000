class MusicImporter

  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files
    total_array = Dir.entries(self.path)
    total_array.select{|files| files.end_with?("3") }
  end

  def import
    files.each do |song_info|
      Song.create_from_filename(song_info)
    end
  end



end
