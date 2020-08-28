class Favorites
  attr_reader :pets

  def initialize(initial_pets)
    @pets = initial_pets || Hash.new(0)
  end

  def total_count
    @pets.values.sum
  end
end 
