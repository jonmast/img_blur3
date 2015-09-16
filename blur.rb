class Image
  attr_reader :pixels
  attr_accessor :width, :height

  ADJACENCY_MASK = [
    [-1, 0],
    [0, 1],
    [1, 0],
    [0, -1]
  ]

  def initialize(pixels)
    @pixels = pixels
    self.width = pixels[0].length
    self.height = pixels.length
  end

  def set_pixel(index, value)
    row_idx, col_idx = index
    pixels[row_idx][col_idx] = value
  end

  def valid_index?(index)
    valid_row?(index[0]) && valid_col?(index[1])
  end

  def valid_row?(index)
    index.between?(0, width - 1)
  end

  def valid_col?(index)
    index.between?(0, height - 1)
  end

  def blur_pixels(index_array)
    index_array.each do |index|
      set_pixel(index, 1)
    end
  end

  def adjacent_pixels(index)
    indexes = []
    ADJACENCY_MASK.each do |mask|
      # Add the columns of the arrays
      masked_index = [index, mask].transpose.map { |to_sum| to_sum.reduce(:+) }
      indexes.push(masked_index) if valid_index?(masked_index)
    end
    indexes
  end

  def ones
    ones = []
    pixels.each_with_index do |col, row_idx|
      col.each_with_index do |value, col_idx|
        ones << [row_idx, col_idx] if value == 1
      end
    end
    ones
  end

  def blur
    to_blur = []
    ones.each do |idx|
      to_blur += adjacent_pixels(idx)
    end
    blur_pixels(to_blur)
  end

  def to_s
    pixels.collect(&:join).join("\n")
  end

  def output_image
    puts to_str
  end
end
