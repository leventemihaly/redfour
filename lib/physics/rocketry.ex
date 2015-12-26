defmodule Physics.Rocketry do
  
  import Calcs
  import Physics.Laws
  
  def escape_velocity(:earth), do: escape_velocity(Planets.earth)      
  def escape_velocity(:mars), do: escape_velocity(Planets.mars)
  def escape_velocity(:moon), do: escape_velocity(Planets.moon)
  def escape_velocity(planet) when is_map(planet) do
    planet
      |> calculate_escape
      |> to_km
      |> to_nearest_tenth
  end
  
  # v = √(GM/R)  
  def orbital_speed(height), do: orbital_speed(Planets.earth, height)  
  def orbital_speed(planet, height) do
    newtons_gravitational_constant * planet.mass / orbital_radius(planet, height)
      |> square_root
  end
  
  # a = v^2/R
  def orbital_acceleration(height), do: orbital_acceleration(Planets.earth, height) 
  def orbital_acceleration(:earth, height), do: orbital_acceleration(Planets.earth, height)
  def orbital_acceleration(:mars, height), do: orbital_acceleration(Planets.mars, height)
  def orbital_acceleration(:moon, height), do: orbital_acceleration(Planets.moon, height)
  def orbital_acceleration(planet, height) do
    (orbital_speed(planet, height) |> squared) / orbital_radius(planet, height)
  end
  
  # T^2/R^3 = 4 * π^2 / G * M
  # T = √(4 * π^2 * R^3) / G * M
  def orbital_term(height), do: orbital_term(Planets.earth, height)  
  def orbital_term(:earth, height), do: orbital_term(Planets.earth, height)
  def orbital_term(:mars, height), do: orbital_term(Planets.mars, height)
  def orbital_term(:moon, height), do: orbital_term(Planets.moon, height)
  def orbital_term(planet, height) do
    4 * (:math.pi |> squared) * (orbital_radius(planet, height) |> cubed) / (newtons_gravitational_constant * planet.mass)
      |> square_root
      |> seconds_to_hours
  end
  
  # R = ∛G * M * T^2 / 4 * π^2
  def orbital_height(term), do: orbital_height(term, Planets.earth)  
  def orbital_height(term, planet) do
    newtons_gravitational_constant * planet.mass * (term |> squared) / 4 * (:math.pi |> squared)
      |> cube_root
      |> to_km
  end
  
  # Ve = √(2GM/R)
  defp calculate_escape(%{mass: mass, radius: radius}) do    
    2 * newtons_gravitational_constant * mass / radius
      |> square_root
  end
  
  defp orbital_radius(planet, height) do
    planet.radius + (height |> to_m)
  end
  
end