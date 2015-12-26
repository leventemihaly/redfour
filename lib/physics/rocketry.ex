defmodule Physics.Rocketry do
  
  import Calcs
  import Physics.Laws
  import Planets
  
  def escape_velocity(:earth) do
    earth
      |> escape_velocity      
  end
  
  def escape_velocity(:mars) do
     %{mass: 6.39e23, radius: 3.4e6}
      |> escape_velocity      
  end
  
  def escape_velocity(:moon) do
     %{mass: 7.35e22, radius: 1.738e6}
      |> escape_velocity      
  end
  
  def escape_velocity(planet) when is_map(planet) do
    planet
      |> calculate_escape
      |> to_km
      |> to_nearest_tenth
  end
  
  defp calculate_escape(%{mass: mass, radius: radius}) do    
    2 * newtons_gravitational_constant * mass / radius
      |> square_root
  end
  
end