require 'csv'

namespace :migrate do
  desc 'Read movies.csv and store in DB'
  task movies: :environment do
    batch_size = 100
    path_to_csv = Rails.root.join('public', 'movies.csv')
    File.open(path_to_csv) do |file|
      headers = file.first
      file.lazy.each_slice(batch_size) do |lines|
        csv_rows = CSV.parse(lines.join, headers: headers)
        csv_rows.each do |row|
          director = Director.find_or_create_by!(name: row['Director'])
          actor = Actor.find_or_create_by!(name: row['Actor'])
          country = Country.find_or_create_by!(name: row['Country'])
          location = Location.find_or_create_by!(name: row['Filming location'],
                                                 country: country)
          movie = Movie.find_or_initialize_by(name: row['Movie'],
                                              description: row['Description'],
                                              year: row['Year'])

          movie.locations << location unless movie.locations.exists?(id: location.id)
          movie.actors << actor unless movie.actors.exists?(id: actor)
          movie.director = director
          movie.save!
        end
      end
    end
  end

  desc 'Read reviews.csv and store in DB'
  task reviews: :environment do
    batch_size = 100
    path_to_csv = Rails.root.join('public', 'reviews.csv')
    File.open(path_to_csv) do |file|
      headers = file.first
      file.lazy.each_slice(batch_size) do |lines|
        csv_rows = CSV.parse(lines.join, headers: headers)
        csv_rows.each do |row|
          movie = Movie.find_by(name: row['Movie'])
          user = User.find_or_create_by!(name: row['User'])
          Review.create!(stars: row['Stars'],
                         comment: row['Review'],
                         movie: movie,
                         user: user)
        end
      end
    end
  end
end
