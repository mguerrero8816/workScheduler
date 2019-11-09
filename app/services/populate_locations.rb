class PopulateLocations
  class << self
    def call(filename='public/locations.csv')
      p filename
      file_string = File.read(filename)
      p file_string
    end
  end
end
