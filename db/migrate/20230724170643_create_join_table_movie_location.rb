class CreateJoinTableMovieLocation < ActiveRecord::Migration[7.0]
  def change
    create_join_table :movies, :locations do |t|
      t.index :movie_id
      t.index :location_id
    end
  end
end
