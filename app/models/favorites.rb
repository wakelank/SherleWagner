class Favorites
   attr_accessor :all

  def initialize(args)
    @all = make_favorites_from(args[:favorites])
  end

  def make_favorites_from(args)
    arr = []
    args.each do |arg|
      arg.keys.each do |key|
        arg[key.to_sym] = arg[key]
        arg.delete(key)
      end
      favorite = Favorite.new(arg) || NullObject.new
      arr << favorite
    end
    arr
  end

  def next_id
    max_id = @all.reduce(0) do |memo, favorite|
      id = favorite.id || 0
      memo > id ? memo : id
    end 
    max_id + 1
  end

  def save(favorite)
    @all << favorite
  end

  def delete(favorite_id)
    puts '========================'
  end


end 
