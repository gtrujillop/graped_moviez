require "graped_moviez/models/movie"

RSpec.describe GrapedMoviez::Models::Movie do

  let(:movie) { build(:movie) }
  
  describe 'fields' do
    it 'has a name' do
      expect(movie).to be_valid
    end
    it 'has a description' do
      expect(movie).to be_valid
    end
  end
end
