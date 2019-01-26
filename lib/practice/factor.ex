defmodule Practice.Factor do
  def factor(x) do
    helper(x,2,[])
  end
  def helper(x,num,result) do
    cond do
      x < num ->
        result
      x == num ->
        result ++ [num]
      rem(x,num) == 0 ->
        helper(div(x,num),num,result++[num])
      rem(x,num) != 0 ->
        helper(x, num+1, result)
      end
  end
end
