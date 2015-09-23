require 'minitest/autorun'
require_relative 'array'

class ArrayTest < MiniTest::Test
  def test_mean_with_several_elements
    assert_equal 11.25, [40, 20, 4, 5, 7, 2, 10, 2].mean
  end

  def test_mean_with_one_element
    assert_equal 5, [5].mean
  end

  def test_mean_with_no_elements
    assert_equal nil, [].mean
  end

  def test_median_with_several_elements_of_odd_number
    assert_equal 5, [2, 3, 4, 5, 6, 7, 8].median
  end

  def test_median_with_several_elements_of_even_number
    assert_equal 5, [10, 8, 4, 5, 6, 7, 3, 2].median
  end

  def test_median_with_single_element
    assert_equal 3, [3].median
  end

  def test_median_with_no_elements
    assert_equal nil, [].median
  end

  def test_mode_with_several_elements_of_single_mode
    assert_equal 7, [2, 3, 2, 4, 5, 4, 6, 7, 8, 7, 7, 7].mode
  end

  def test_mode_with_several_elements_of_multiple_modes
    # returns the one with smallest index number among multiple modes
    assert_equal 2, [2, 3, 2, 4, 5, 4, 6, 7, 8, 2, 7, 7].mode
  end

  def test_mode_with_single_element
    assert_equal 3, [3].mode
  end

  def test_mode_with_no_elements
    assert_equal nil, [].mode
  end
end
