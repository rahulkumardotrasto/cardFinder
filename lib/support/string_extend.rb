class String
  def titelize
    self.split(' ').collect { |word| word.capitalize}.join(" ")
  end
end
