module HtmlPretty
  VERSION = '0.0.1'

  # Really bad assumption heavy tidy...
  # Self rolled because other versions have weird errors
  class << self
    def run(html)
      html = html.gsub(/^[ \t]*\n/, "")   # kill blank lines
      html = html.gsub(/^[ \t]+/, '')     # kill opening whitespace
      html = html.gsub(/[ \t]+$/, '')     # kill closing whitespace
      html = html.gsub(/[ \t]+/, ' ')     # collapse all whitespace
      html = html.gsub(/<[ \t]+/, '<')    # remove whitespace between brackets
      html = html.gsub(/[ \t]+>/, '>')    # remove whitespace between brackets

      indent = 0
      html.map do |line|
        if line.start_with?('<!') || line =~ /<html.*ie/
          line                            # Comments should have no alignment
        else
          open_tags = line.scan(/<[^\/>]*>/).size
          close_tags = line.scan(/<\/[^>]*>/).size
          if open_tags > close_tags
            val = "  " * indent + line
            indent += open_tags - close_tags
            val
          else
            indent += open_tags - close_tags
            "  " * indent + line
          end
        end
      end.join
    end
  end
end
