class Image
  attr_reader :pixels
  attr_accessor :width, :height

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

  def valid_manhattan?(offset, distance)
    offset[0].abs + offset[1].abs <= distance
  end

  def blur_pixels(index_array)
    index_array.each do |index|
      set_pixel(index, 1)
    end
  end

  def adjacent_pixels(index, distance)
    indexes = []
    (-distance).upto(distance) do |row|
      (-distance).upto(distance) do |col|
        next unless valid_manhattan?([row, col], distance)
        idx = [index[0] - row, index[1] - col]
        indexes.push idx if valid_index?(idx)
      end
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

  def blur(distance)
    to_blur = []
    ones.each do |idx|
      to_blur += adjacent_pixels(idx, distance)
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
