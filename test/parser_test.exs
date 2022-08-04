defmodule ReportsGenerator.ParserTest do
  use ExUnit.Case

  alias ReportsGenerator.Parser

  describe "parse_file/1" do
    test "parses the file" do
      file_name = "report_test.csv"

      response =
        file_name
        |> Parser.parse_file()
        |> Enum.map(& &1)

      expected_response = [
        ["1", "pizza", 48],
        ["2", "açaí", 45],
        ["3", "hambúrguer", 31],
        ["4", "esfirra", 42],
        ["5", "hambúrguer", 49],
        ["6", "esfirra", 18],
        ["7", "pizza", 27],
        ["8", "esfirra", 25],
        ["9", "churrasco", 24],
        ["10", "churrasco", 36]
      ]

      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is 'users', return the user who spent the most" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end
  end

  test "when the option is 'foods', return the most consumed food" do
    file_name = "report_test.csv"

    response =
      file_name
      |> ReportsGenerator.build()
      |> ReportsGenerator.fetch_higher_cost("foods")

    expected_response = {:ok, {"esfirra", 3}}

    assert response == expected_response
  end

  test "when an invalid option, returns an error" do
    file_name = "report_test.csv"

    response =
      file_name
      |> ReportsGenerator.build()
      |> ReportsGenerator.fetch_higher_cost("banana")

    expected_response = {:error, "Invalid Option!"}

    assert response == expected_response
  end
end
