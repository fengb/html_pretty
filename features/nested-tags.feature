Feature: nested tags
  Scenario: indent with outstanding opening tag:
       When the input is:
            """
            <html>
            <hi>
            </hi>
            </html>
            """
       Then the output is:
            """
            <html>
              <hi>
              </hi>
            </html>
            """

  Scenario: indent with text on either side
       When the input is:
            """
            <html>
            <spam>abc
            123</spam>
            </html>
            """
       Then the output is:
            """
            <html>
              <spam>abc
              123</spam>
            </html>
            """

  Scenario: indent with multiple opening tags
       When the input is:
            """
            <html>
            <hi>
            <bye>
            </bye>
            </hi>
            </html>
            """
       Then the output is:
            """
            <html>
              <hi>
                <bye>
                </bye>
              </hi>
            </html>
            """

  Scenario: indent with multiple opening tags on one line
       When the input is:
            """
            <html><hi><bye>
            </bye>
            </hi>
            </html>
            """
       Then the output is:
            """
            <html><hi><bye>
                </bye>
              </hi>
            </html>
            """

  Scenario: do not indent further with self closing tags
       When the input is:
            """
            <html>
            <hi />
            <bye />
            </html>
            """
       Then the output is:
            """
            <html>
              <hi />
              <bye />
            </html>
            """

  Scenario: indents hrefs
       When the input is:
            """
            <a href='http://www.google.com'>
            something
            </a>
            """
       Then the output is:
            """
            <a href='http://www.google.com'>
              something
            </a>
            """
