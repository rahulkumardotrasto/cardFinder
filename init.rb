APP_ROOT = File.dirname(__FILE__)
#require "#{APP_ROOT}/lib/guide"
$:.unshift(File.join(APP_ROOT,'lib'))
require 'guide'
 guide = Guide.new('card.txt')
 guide.launch!
