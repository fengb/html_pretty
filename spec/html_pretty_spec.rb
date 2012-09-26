require 'html_pretty'

require 'yaml'
data = YAML.load_file(__FILE__.sub(/rb$/, 'yaml'))

def parse_describe(name, hash)
  describe name do
    hash.each do |child_name, child_hash|
      if child_hash.has_key?('in')
        it child_name do
          output = HtmlPretty.fake_tidy(child_hash['in'])
          output.should == child_hash['out'].sub(/\n$/, '')
        end
      else
        parse_describe(child_name, child_hash)
      end
    end
  end
end

parse_describe(HtmlPretty, data)
