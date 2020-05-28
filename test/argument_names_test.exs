defmodule ArgumentNamesTest do
  use ExUnit.Case
  doctest ArgumentNames

  import Helpers

  test "No named arguments" do
    assert named(1, 2, 3) == [1, 2, 3]
  end

  describe "one named argument" do
    test "first position" do
      assert named(a ~> 1, 2, 3) == [1, 2, 3]
      assert named(2, a ~> 1, 3) == [1, 2, 3]
      assert named(2, 3, a ~> 1) == [1, 2, 3]
    end

    test "second position" do
      assert named(b ~> 2, 1, 3) == [1, 2, 3]
      assert named(1, b ~> 2, 3) == [1, 2, 3]
      assert named(1, 3, b ~> 2) == [1, 2, 3]
    end

    test "third position" do
      assert named(c ~> 3, 1, 2) == [1, 2, 3]
      assert named(1, c ~> 3, 2) == [1, 2, 3]
      assert named(1, 2, c ~> 3) == [1, 2, 3]
    end
  end

  describe "two named arguments" do
    test "first and second position" do
      assert named(a ~> 1, b ~> 2, 3) == [1, 2, 3]
      assert named(a ~> 1, 3, b ~> 2) == [1, 2, 3]

      assert named(b ~> 2, a ~> 1, 3) == [1, 2, 3]
      assert named(3, a ~> 1, b ~> 2) == [1, 2, 3]

      assert named(b ~> 2, 3, a ~> 1) == [1, 2, 3]
      assert named(3, b ~> 2, a ~> 1) == [1, 2, 3]
    end
  end

  test "works with variables" do
    a = 1
    b = 2
    c = 3

    assert named(a ~> a, b ~> b, c ~> c) == [1, 2, 3]
    assert named(c ~> c, a ~> a, b ~> b) == [1, 2, 3]
    assert named(a ~> a, 2, c ~> c) == [1, 2, 3]
  end

  test "works well with pipes" do
    assert 3 |> named(a ~> 1, b ~> 2) == [1, 2, 3]
  end

  test "works with function calls" do
    assert named(String.length("1"), 2, 3) == [1, 2, 3]
    assert named(b ~> (1 + 1), 1, 3) == [1, 2, 3]
  end
end
