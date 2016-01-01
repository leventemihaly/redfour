defmodule Solar.Flare do

  defstruct [
    classification: :M,
    scale: 0,
    power: 0,
    is_deadly: false,
    date: nil
  ]
  
  
  def calculate_power(flare) do
    factor = case flare.classification do
      :X -> 1000
      :M -> 10
      :C -> 1
    end
    %{flare | power: factor * flare.scale}  
  end

  def calculate_deadliness(flare) do    
    %{flare | is_deadly: flare.power > 1000}    
  end
  
  def no_eva(flares) do
    Enum.filter flares, fn(flare) ->
      flare.power > 1000
    end
  end
  
  def deadliest(flares) do
    Enum.map(flares, fn(flare) -> flare.power end)
      |> Enum.max
  end
  
  def sum(flares) do
    Enum.reduce flares, 0, fn(flare,total) -> 
      flare.power + total
    end
  end
  
  def load(flares) do
    #Enum.map flares, fn(flare) ->
    #  flare
    #    |> calculate_power
    #    |> calculate_deadliness
    #end
    for flare <- flares, do: flare |> calculate_power |> calculate_deadliness
  end

  
end