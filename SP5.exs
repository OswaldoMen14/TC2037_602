#Dulce Daniela García Ruíz A01748013
#Oswaldo Ilhuicatzi Mendizábal A01781988

#Python Syntax Highlighter

defmodule PythonLexer do
  # This module provides functions for highlighting Python syntax in a file

  def highlight_syntax(file_path) do
    # Reads the file contents
    file = File.read!(file_path)

    # Tokenizes the file contents
    tokens = tokenize(file)

    # Generates HTML representation of the tokens
    html = generate_html(tokens)

    # Writes the HTML output to a file
    File.write("output.html", html)
  end

  def tokenize(file) do
    # Regular expressions for different types of tokens
    regex_comments = ~r/#(.*)$/  # Matches single line comments starting with '#' and the text with it
    regex_string_literals = ~r/("([^"\\]|\\.)*"|'([^'\\]|\\.)*')/  # Matches string literals
    regex_boolean_literals = ~r/(True|False)/  # Matches boolean literals (True, False)
    regex_operators = ~r/(\+|\-|\*|\/|%|=|==|!=|>|<|>=|<=|and|or|not)/  # Matches operators
    regex_none_literal = ~r/(None)/  # Matches the 'None' literal
    regex_delimiters = ~r/(\(|\)|\[|\]|\{|\}|,|:|\.)/  # Matches delimiters
    regex_identifiers = ~r/(?:'[^']*'|"[^"]*"|[a-zA-Z_][a-zA-Z0-9_]*)\b/  # Matches identifiers (variables)
    regex_keywords = ~r/(if|else|elif|while|for|in|def|class|try|except|finally|raise|import|from|as|return|break|continue|pass|global|nonlocal|lambda|with|assert|yield|print)/  # Matches keywords
    regex_numerical_literals = ~r/(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?/  # Matches numerical literals

    # Splits the file into tokens based on whitespace
    tokens = Enum.reduce(String.split(file,  ~r/(?<!\\)(?<![\w'"])\s+|\s+(?![\w'"])/), [], fn token, acc ->
      categorized_token =
        if Regex.match?(regex_keywords, token), do: {:keyword, token},  # Categorizes the token as a keyword
        else: if Regex.match?(regex_comments, token), do: {:comment, token},  # Categorizes the token as a comment
        else: if Regex.match?(regex_string_literals, token), do: {:string_literal, token},  # Categorizes the token as a string literal
        else: if Regex.match?(regex_boolean_literals, token), do: {:boolean_literal, token},  # Categorizes the token as a boolean literal
        else: if Regex.match?(regex_operators, token), do: {:operator, token},  # Categorizes the token as an operator
        else: if Regex.match?(regex_none_literal, token), do: {:none_literal, token},  # Categorizes the token as the 'None' literal
        else: if Regex.match?(regex_delimiters, token), do: {:delimiter, token},  # Categorizes the token as a delimiter
        else: if Regex.match?(regex_identifiers, token), do: {:identifier, token},  # Categorizes the token as an identifier
        else: if Regex.match?(regex_numerical_literals, token), do: {:numeric_literal, token},  # Categorizes the token as a numerical literal
        else: {:unknown, token}  # Categorizes the token as unknown if it doesn't match any patterns

      acc ++ [categorized_token]  # Accumulates the categorized token
    end)

    tokens
  end

  def generate_html(tokens) do
    # HTML header for the output file
    html_header = """
      <!DOCTYPE html>
      <html>
      <head>
      <link href="/syntax_highlighter.css" type="text/css" rel="stylesheet">
      </head>
      <body>
    """

    # HTML footer for the output file
    html_footer = """
      </body>
      </html>
    """

    # Converts each token to an HTML span element with the appropriate class
    html_tokens = Enum.map(tokens, fn {category, value} ->
      "<span class=\"#{category}\">#{String.replace(value, ~r/(?<!\\)"/, "&quot;")}</span>\n"
    end)

    # Concatenates the HTML header, token elements, and footer
    html = html_header <> Enum.join(html_tokens) <> html_footer

    html  # Returns the generated HTML
  end
end

# Calls the highlight_syntax function with the path to the python test files
#PythonLexer.highlight_syntax("test_one.py")
PythonLexer.highlight_syntax("test_two.py")
#PythonLexer.highlight_syntax("test_three.py")
