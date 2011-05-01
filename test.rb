# Shuffle letters in a string
def string_shuf s
	puts "Shuffling " + s
	s.split(//).to_a.shuffle.to_s
end


class String
	def shuffle
		puts "Shuffling " + self
		self.split(//).to_a.shuffle.to_s
	end
end

@person1 = {:first=>"Bill", :last=>"Murray"}
@person2 = {:first=>"Sally", :last=>"Wilson"}
@person2 = {:first=>"Betty", :last=>"Boop"}
@params = {:father=>@person1, :mother=>@person2, :child=>@person3}

puts @params[:father][:first]

@fox="hello foxy"


