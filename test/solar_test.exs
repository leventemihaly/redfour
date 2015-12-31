defmodule SolarTest do
  
  use ExUnit.Case
  use Timex
  
  setup do
    flares = [
      %{classification: :X, scale: 99, date: Date.from({1859, 8, 29})},
      %{classification: :M, scale: 5.8, date: Date.from({2015, 1, 12})},
      %{classification: :M, scale: 1.2, date: Date.from({2015, 2, 9})},
      %{classification: :C, scale: 3.2, date: Date.from({2015, 4, 18})},
      %{classification: :M, scale: 83.6, date: Date.from({2015, 6, 23})},
      %{classification: :C, scale: 2.5, date: Date.from({2015, 7, 4})},
      %{classification: :X, scale: 72, date: Date.from({2012, 7, 23})},
      %{classification: :X, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end
  
  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end
  
  test "power of class X" do
   power = Solar.power(%{classification: :X, scale: 99, date: Date.from({1859, 8, 29})})
   assert power == 99 * 1000
  end
  
  test "power of class M" do
   power = Solar.power(%{classification: :M, scale: 99, date: Date.from({1859, 8, 29})})
   assert power == 99 * 10
  end
  
  test "power of class C" do
   power = Solar.power(%{classification: :C, scale: 99, date: Date.from({1859, 8, 29})})
   assert power == 99 * 1
  end
  
  test "Go inside", %{data: flares} do
    no_eva = Solar.no_eva(flares)
    assert length(no_eva) == 3
  end
  
  test "deadliest", %{data: flares} do
    d = Solar.deadliest(flares)
    assert d == 99000
  end
  
  test "sum", %{data: flares} do
    s = Solar.sum(flares)
    assert s == 216911.7
  end
  
  test "A list of flares", %{data: flares} do
    result = Solar.flare_list(flares)
    result2 = Solar.flare_list2(flares)
    assert result == [
      %{power: 99000, is_deadly: true},
      %{power: 58.0, is_deadly: false},
      %{power: 12.0, is_deadly: false},
      %{power: 3.2, is_deadly: false},
      %{power: 836.0, is_deadly: false},
      %{power: 2.5, is_deadly: false},
      %{power: 72000, is_deadly: true},
      %{power: 45000, is_deadly: true}
   ] #true
   assert result == result2
  end
  
end