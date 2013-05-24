Feature: malformed document
  Scenario: indents correctly even after descender fails
       When the input is:
            """
            <html>
            </title>
            </head>
            <body>
            <p></p>
            </body>
            </html>
            """
       Then the output is:
            """
            <html>
            </title>
            </head>
            <body>
              <p></p>
            </body>
            </html>
            """
