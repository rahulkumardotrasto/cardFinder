require 'support/number_helper'

class Card
  include NumberHelper
  @@filepath=nil
  attr_accessor :brand, :category, :price
  def self.filepath=(path=nil)
    @@filepath=File.join(APP_ROOT, path)

  end
  def self.file_exists?
    if @@filepath && File.exists?(@@filepath)
      return true
    else return false

    end
  end
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end
  def self.create_file
    File.open(@@filepath,'w') unless file_exists?
    return file_usable?
  end

  def self.build_using_questions
    args = {}
    print "Card brand: "
    args[:brand] = gets.chomp.strip
    print "Card category: "
    args[:category] = gets.chomp.strip
    print "Card price: "
    args[:price] = gets.chomp.strip
    return self.new(args)

  end


  def self.saved_cards
    cards=[]
    if file_usable?
      file=File.new(@@filepath,'r')
      file.each_line do |line|
        cards << Card.new.import_line(line.chomp)
      end
      file.close
    end
    return cards

  end

  def initialize(args={})
    @brand=args[:brand]  || ""
    @category=args[:category] || ""
    @price=args[:price] || ""
  end
def import_line(line)
  line_array = line.split("\t")
  @brand, @category, @price = line_array
  return self
end

  def save
    return false unless Card.file_usable?
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@brand, @category, @price].join("\t")}\n"
  end
  return true
end
def formatted_price
  number_to_currency(@price)
end
end
