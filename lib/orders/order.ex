defmodule Exlivery.Orders.Order do
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  @keys [:user_cpf, :delivery_address, :items, :total_price]

  @enforce_keys @keys

  defstruct @keys

  def build(%User{address: address, cpf: cpf}, [%Item{} | _items] = items) do
    {:ok,
      %__MODULE__{
        user_cpf: cpf,
        delivery_address: address,
        items: items,
        total_price: calculate_total_price(items)
      }
    }
  end

  def build(_user, _items), do: {:error, "Invalid parameters"}

  def calculate_total_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), 
      &sum_prices(&1,&2))
  end

  def sum_prices(
      %Item{unit_price: price,unit: unit }, acc) do
    price
    |> Decimal.mult(unit)
    |> Decimal.add(acc)
  end

end
