defmodule SolarTest do
  
  use ExUnit.Case
  use Timex
  import Solar.Flare
  
  setup do
    flares = [
      %Solar.Flare{classification: :X, scale: 99, date: Date.from({1859, 8, 29})},
      %Solar.Flare{classification: :M, scale: 5.8, date: Date.from({2015, 1, 12})},
      %Solar.Flare{classification: :M, scale: 1.2, date: Date.from({2015, 2, 9})},
      %Solar.Flare{classification: :C, scale: 3.2, date: Date.from({2015, 4, 18})},
      %Solar.Flare{classification: :M, scale: 83.6, date: Date.from({2015, 6, 23})},
      %Solar.Flare{classification: :C, scale: 2.5, date: Date.from({2015, 7, 4})},
      %Solar.Flare{classification: :X, scale: 72, date: Date.from({2012, 7, 23})},
      %Solar.Flare{classification: :X, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end
  
  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end
  
  test "power of class X" do
   flare = calculate_power(%Solar.Flare{classification: :X, scale: 99, date: Date.from({1859, 8, 29})})
   assert flare.power == 99 * 1000
  end
  
  test "power of class M" do
   flare = calculate_power(%Solar.Flare{classification: :M, scale: 99, date: Date.from({1859, 8, 29})})
   assert flare.power == 99 * 10
  end
  
  test "power of class C" do
   flare = calculate_power(%Solar.Flare{classification: :C, scale: 99, date: Date.from({1859, 8, 29})})
   assert flare.power == 99 * 1
  end
  
  test "Go inside", %{data: flares} do
    loaded = load(flares)
    n = no_eva(loaded)
    assert length(n) == 3
  end
  
  test "deadliest", %{data: flares} do
    loaded = load(flares)
    d = deadliest(loaded)
    assert d == 99000
  end
  
  test "sum", %{data: flares} do
    loaded = load(flares)
    s = sum(loaded)
    assert s == 216911.7
  end    
  
  test "A Solar Flare is a Map with a special key" do
    assert %Solar.Flare{}.__struct__ == Solar.Flare
  end
  
  test "load flares", %{data: flares} do
    loaded = load(flares)
    flare = Enum.at(loaded, 0)
    assert flare.power == 99000
    assert flare.is_deadly == true
  end
  
end