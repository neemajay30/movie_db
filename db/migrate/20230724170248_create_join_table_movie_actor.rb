class CreateJoinTableMovieActor < ActiveRecord::Migration[7.0]
  def change
    create_join_table :movies, :actors do |t|
      t.index :movie_id
      t.index :actor_id
    end
  end
end
