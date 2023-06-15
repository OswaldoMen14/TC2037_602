defmodule Primes do

  # Dulce Daniela García Ruíz
  # Oswaldo Ilhuicatzi Mendizábal
  # 14/06/2023

  #----------------------------------------------------------------------------------------
  # Función para verificar si un número es primo utilizando recursión
  defp is_prime(number) when number < 2, do: false
  defp is_prime(2), do: true
  defp is_prime(3), do: true
  defp is_prime(number), do: is_prime_recursive(number, 2)

  # Función recursiva auxiliar para verificar si un número es primo
  defp is_prime_recursive(number, divisor) when divisor >= number, do: true
  defp is_prime_recursive(number, divisor) do
    if rem(number, divisor) == 0 do
      false
    else
      is_prime_recursive(number, divisor + 1)
    end
  end

  # Función para sumar los números primos en un rango dado
  def range_sum({start, finish}) do
    range_sum_recursive(start, finish, 0)
  end

  # Función recursiva auxiliar para sumar los números primos en un rango dado
  defp range_sum_recursive(start, finish, acc) do
    if start > finish do
      acc
    else
      new_acc = if is_prime(start), do: acc + start, else: acc
      range_sum_recursive(start + 1, finish, new_acc)
    end
  end

  # Función para generar los rangos de números a procesar en paralelo
  def make_ranges(start, finish, cores) do
    range_size = div(finish - start + 1, cores)
    ranges = Enum.map(0..(cores - 1), fn index ->
      range_start = start + (index * range_size)
      range_end = range_start + range_size - 1
      {range_start, range_end}
    end)
    ranges
  end

  # Función para sumar los números primos en paralelo utilizando múltiples hilos (cores)
  def sum_primes_parallel(start, finish, cores) do
    ranges = make_ranges(start, finish, cores)
    sums = ranges
      |> Enum.map(&Task.async(fn -> range_sum(&1) end))
      |> Enum.map(&Task.await(&1, :infinity))
      |> IO.inspect()
    Enum.sum(sums)
  end

  # Función para sumar los números primos en un rango dado (versión secuencial)
  def sum_primes(start,limit) do
    range_sum({start,limit})
  end

end
