# Monkeypatching Array for mean, median, and mode.
# Mode returns the element of smallest index if there are more than one

class Array
  def mean
    return nil if empty?

    reduce(:+).to_f / length
  end

  def median
    return nil if empty?

    mid_index = ((length.odd? ? length + 1 : length) / 2) - 1

    sort[mid_index]
  end

  def mode
    return nil if empty?

    counter = Hash.new(0)

    each { |e| counter[e] += 1 }

    counter.sort_by { |_k, v| -v }[0][0]
  end
end
