defmodule Exlivery.Users.User do
  @keys [:name, :email, :cpf, :address, :age]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, cpf, address, age) when age >= 18 and is_bitstring(cpf)  do
    {:ok,
      %__MODULE__{
        address: address,
        name: name,
        email: email,
        cpf: cpf,
        age: age
      }
    }
  end

  def build(_name, _email, _cpf, _age, _address), do: {:error, "Invalid parameters"}
end
