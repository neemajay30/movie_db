class AddDirectorToMovie < ActiveRecord::Migration[7.0]
  def change
    add_reference :movies, :director, foreign_key: true
  end
end
