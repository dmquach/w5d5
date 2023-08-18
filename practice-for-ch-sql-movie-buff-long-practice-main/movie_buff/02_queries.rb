def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5
  # (inclusive). Show the id, title, year, and score.
  Movie
    .select(:id, :title, :yr, :score)
    .where(yr: 1980..1989, score: 3..5)
end

def bad_years
  # List the years in which no movie with a rating above 8 was released.
  Movie
    .where("score < 8 AND yr NOT IN (
      SELECT yr
      FROM movies
      WHERE score > 8
      GROUP BY yr
    )")
    .group(:yr)
    .pluck(:yr)
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor
    .select(:id, :name)
    .joins(:movies)
    .where(movies: {title: title})
    .order("ord ASC")
end

def vanity_projects
  # List the title of all movies in which the director also appeared as the
  # starring actor. Show the movie id, title, and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie
    .select(:id, :title, :director_id)
    .joins(:castings)
    .where("castings.order = 1 AND castings.actor_id = movies.director_id")
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name, and number of supporting roles.
  
end