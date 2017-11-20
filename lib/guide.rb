require 'Card'
require 'support/string_extend'
class Guide
  class Config
    @@actions = ['list', 'find','add','quit']
    def self.actions; @@actions; end
  end

  def initialize(path=nil)
Card.filepath=path

if Card.file_usable?
  puts "Found card file"
elsif Card.create_file

  puts "Created card file"
else
  puts "Exiting.\n\n"
  exit!
end
end

def launch!
  introduction
  result =nil
  until result == :quit
action, args = get_action
result = do_action(action, args)



  end

  conclusion
end

def get_action
  action = nil
  until Guide::Config.actions.include?(action)
puts "Actions: " + Guide::Config.actions.join(", ") if action
  print "> "
  user_response = gets.chomp
  args = user_response.downcase.strip.split(' ')
  action= args.shift

end
return action, args
end


def do_action(action, args=[])
  case action
  when 'list'
  list(args)


when 'find'
  keyword = args.shift
  find(keyword)

  when 'add'
add
when 'quit'
  return :quit
else
  puts "\nI don't understand that command.\n"
end
end


def find(keyword="")
output_action_header("Find a card")
if keyword
cards=Card.saved_cards
found= cards.select do | c |

c.brand.downcase.include?(keyword.downcase) ||
c.category.downcase.include?(keyword.downcase) ||
c.price.to_i <= keyword.to_i


end


output_card(found)
else
  puts "Find using a key phrase to search the card list "
  puts "Examples:  'find price'\n\n"

end





end


def list(args=[])
  sort_order=args.shift


  sort_order = "brand" unless ['brand', 'category', 'price'].include?(sort_order)


output_action_header("Listing cards")
cards=Card.saved_cards

cards.sort! do |r1, r2|
  case sort_order
  when 'brand'
  r1.brand.downcase <=> r2.brand.downcase
when 'category'
    r1.category.downcase <=> r2.category.downcase
when 'price'
  r1.price.to_i <=> r2.price.to_i

end

end





output_card(cards)
puts "sort using: 'list khushi\n\n'"
end
def add
  output_action_header("Add A Card")


card=Card.build_using_questions
if card.save
  puts "\nCard Added\n\n"
else
  puts "\nError: Card not added\n\n"
end



end
  def introduction
    puts "\n\n<<<Welcome to the Card Finder>>>\n\n"
    puts "This is an alternative guide to help you find the card you want.\n\n"
  end
  def conclusion
    puts "\n<<< Goodbye >>>\n"
  end

private
def output_action_header(text)
  puts "\n#{text.upcase.center(60)}\n".upcase
end

def output_card(cards=[])
  print " " + "Brand".ljust(30)
  print " " + "Category".ljust(20)
  print " " +  "Price". rjust(6) + "\n"
  puts "-"*60
  cards.each do |c|
    line = " " << c.brand.titelize.ljust(30)
    line << " " + c.category.titelize.ljust(20)
    line << " " + c.formatted_price.rjust(6)
    puts line
  end
  puts "No Listing Found" if cards.empty?
  puts "-"*60












end


end
