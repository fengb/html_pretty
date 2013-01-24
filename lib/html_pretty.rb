module HtmlPretty
  VERSION = '0.0.1'

  # Really bad assumption heavy tidy...
  # Self rolled because other versions have weird errors
  class << self
    def run(html, out='')
      indent = 0
      html.split(/(<!--.*?-->)/).each do |blob|
        if blob.start_with?('<!--!!!-->')
          raise
        elsif blob.start_with?('<!--') || blob =~ /<html.*ie/
          out << blob                     # Comments should have no adjustments
        else
          blob = blob.gsub(/^[ \t]*\n/, "")   # kill blank lines
          blob = blob.gsub(/^[ \t]+/, '')     # kill opening whitespace
          blob = blob.gsub(/[ \t]+$/, '')     # kill closing whitespace
          blob = blob.gsub(/[ \t]+/, ' ')     # collapse all whitespace
          blob = blob.gsub(/<[ \t]+/, '<')    # remove whitespace between brackets
          blob = blob.gsub(/[ \t]+>/, '>')    # remove whitespace between brackets
          blob.each_line do |line|
            open_tags = line.scan(/<[^\/][^>]*>/).select{|d| d !~ /\/>$/}.size
            close_tags = line.scan(/<\/[^>]*>/).size
            if open_tags > close_tags
              out << "  " * indent + line
              indent += open_tags - close_tags
              indent = 0 if indent < 0
            else
              indent += open_tags - close_tags
              indent = 0 if indent < 0
              out << "  " * indent + line
            end
          end
        end
      end

      out
    end
  end
end
