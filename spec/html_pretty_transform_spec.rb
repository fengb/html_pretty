require 'html_pretty'

require 'yaml'
data = YAML.load_file(__FILE__.sub(/rb$/, 'yaml'))

def describe_from_hash(name, hash)
  describe name do
    hash.each do |child_name, child_hash|
      if child_hash.has_key?('in')
        it child_name do
          output = HtmlPretty.run(child_hash['in'])
          output.should == child_hash['out']
        end
      else
        describe_from_hash(child_name, child_hash)
      end
    end
  end
end

describe_from_hash(HtmlPretty, data)
