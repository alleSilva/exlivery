defmodule Exlivery.Orders.Item do
  @categorys [:pizza, :hamburger, :carne, :prato_feito, :comida_japonesa, :sobremesa]

  @keys [:description, :category, :unit_price, :unit]

  @enforce_keys @keys

  defstruct @keys

  def build(description, category, unit_price, unit)
    when unit > 0 and category in @categorys do

    unit_price
    |> Decimal.cast()
    |> build_item(description, category, unit)
  end

  def build(_description,_category, _unit_price, _unit) do
    {:error, "Invalid parameters"}
  end

  defp build_item({:ok,unit_price}, description, category, unit ) do
    {:ok,
        %__MODULE__{
          description: description,
          category: category,
          unit: unit,
          unit_price: unit_price
        }
      }
  end

  defp build_item(:error, _description, _category, _unit), do: {:error,"Invalid price" }

end
