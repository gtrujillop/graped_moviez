require "graped_moviez/models/movie"

RSpec.describe GrapedMoviez::Models::Movie do

  let(:movie) { create(:movie) }
  
  describe '#name' do
    it 'has a name' do
      expect(movie.name).to_not be_nil
    end
  end
end
