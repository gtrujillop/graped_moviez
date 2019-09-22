require "graped_moviez/models/movie"

Sequel.seed do
  def run
    [
      ['Alien', 'Lorem ipsum dolor sit amet.', 'https://images.gowatchit.com/posters/original/p9384_p_v7_as.jpg'],
      ['Star Wars, The Last Jedi', 'Lorem ipsum dolor sit amet.', 'https://i.pinimg.com/originals/f3/c3/8e/f3c38ee96eb5b212330a4f2d967b5699.jpg'],
      ['Paw Patrol Mighty Pups', 'Lorem ipsum dolor sit amet.', 'https://img.elcomercio.pe/files/ec_article_multimedia_gallery/uploads/2019/05/23/5ce6dd0d910df.jpeg']
    ].each do |name, description, image_url|
      GrapedMoviez::Models::Movie.create name: name, description: description, image_url: image_url
    end
  end
end 
