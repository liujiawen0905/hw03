defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> mul_div
    |> add_sub
    |> hd
    |> get_value
  end

  def tag_tokens(l) do
    Enum.map(l, fn x -> create_tuple(x) end)
  end

  def create_tuple(x) do
    if Enum.member?(["+", "-", "*", "/"], x) do
      {:op, x}
    else
      {:num, parse_float(x)}
  end
end

  def mul_div([{:num, n1}, {:op, "*"}, {:num, n2} | rest]) do
    mul_div([{:num, n1 * n2} | rest])
  end

  def mul_div([{:num, n1}, {:op, "/"}, {:num, n2} | rest]) do
    mul_div([{:num, n1 / n2} | rest])
  end

  def mul_div([first | rest]) do
    [first] ++ mul_div(rest)
  end

  def mul_div([]) do
    []
  end

  def add_sub([{:num, n1}, {:op, "+"}, {:num, n2} | rest]) do
    mul_div([{:num, n1 + n2} | rest])
  end

  def add_sub([{:num, n1}, {:op, "-"}, {:num, n2} | rest]) do
    mul_div([{:num, n1 - n2} | rest])
  end

  def add_sub([first | rest]) do
    [first] ++ mul_div(rest)
  end

  def add_sub([]) do
    []
  end

  def get_value(l) do
    elem(l, 1)
  end

end
