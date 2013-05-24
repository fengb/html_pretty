require 'html_pretty'


When 'the input is:' do |input|
  @input = input
end

Then 'the output is:' do |output|
  HtmlPretty.run(@input).should == output
end
