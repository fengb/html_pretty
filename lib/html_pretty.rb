module HtmlPretty
  VERSION = '0.0.1'

  # Really bad assumption heavy tidy...
  # Self rolled because other versions have weird errors
  class << self
    def run(html, out='')
      html = html.gsub(/^[ \t]*\n/, "")   # kill blank lines
      html = html.gsub(/^[ \t]+/, '')     # kill opening whitespace
      html = html.gsub(/[ \t]+$/, '')     # kill closing whitespace
      html = html.gsub(/[ \t]+/, ' ')     # collapse all whitespace
      html = html.gsub(/<[ \t]+/, '<')    # remove whitespace between brackets
      html = html.gsub(/[ \t]+>/, '>')    # remove whitespace between brackets

      indent = 0
      html.each do |line|
        if line.start_with?('<!!!!!>')
          raise
        elsif line.start_with?('<!') || line =~ /<html.*ie/
          out << line                     # Comments should have no alignment
        else
          open_tags = line.scan(/<[^\/>]*>/).size
          close_tags = line.scan(/<\/[^>]*>/).size
          if open_tags > close_tags
            out << "  " * indent + line
            indent += open_tags - close_tags
          else
            indent += open_tags - close_tags
            out << "  " * indent + line
          end
        end
      end

      out
    end
  end
end
