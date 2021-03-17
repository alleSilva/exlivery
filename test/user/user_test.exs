defmodule Exlivery.Users.UserTest do
  alias Exlivery.Users.User
  use ExUnit.Case

  describe "build/5" do
    test "when all parameters are valid, returns the user struct" do
      response = User.build(
        "Alesandro Silva",
        "ale@email.com",
        "32145679900",
        "Rua R, N01, Alvorecer",
        25
      )

      expected_response = {:ok,
        %Exlivery.Users.User{
          address: "Rua R, N01, Alvorecer",
          age: 25, cpf: "32145679900",
          email: "ale@email.com",
          name: "Alesandro Silva"
          }
        }

      assert response == expected_response
    end

    test "when there are invalid parameters returns an error" do
      response = User.build(
        "Alesandro Silva",
        "ale@email.com",
        32145679900,
        "Rua R, N01, Alvorecer",
        25)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
