require 'html_pretty'


describe HtmlPretty do
  it 'outputs work in progress even upon critical failure' do
    out = ''
    expect{HtmlPretty.run("<html>\n<!!!!!>\n</html>", out)}.to raise_exception
    out.should == "<html>\n"
  end
end
