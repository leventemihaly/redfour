defmodule Solar do
  
  def power(%{classification: :X, scale: scale, date: _ }), do: scale * 1000
  def power(%{classification: :M, scale: scale, date: _ }), do: scale * 10
  def power(%{classification: :C, scale: scale, date: _ }), do: scale
  
  def no_eva(flares) do
    Enum.filter flares, fn(flare) ->
      power(flare) > 1000
    end
  end
  
  def deadliest(flares) do
    Enum.map(flares, &(power(&1)))
      |> Enum.max
  end
  
  def sum(flares) do
    Enum.reduce flares, 0, fn(flare,total) -> 
      power(flare) + total
    end
  end
  
  def flare_list(flares) do
    Enum.map flares, fn(flare) ->
      p = power(flare)
      %{power: p, is_deadly: p > 1000}
    end
  end
  
  def flare_list2(flares) do
    for flare <- flares,
      power <- [power(flare)],
      is_deadly <- [power > 1000],
      do: %{power: power, is_deadly: is_deadly}
  end
  
end