# lib/image.rb

class Image
  attr_accessor :image_data, :pixel_array

  def initialize(image_data)
    @image_data = image_data
    @pixel_array = get_pixel_coordinates
  end

  def get_pixel_coordinates
    pixel_array = []
    @image_data.each_with_index do |row_array,row_index|

      row_array.each_index do |column_index|
        pixel_value = @image_data[row_index][column_index]
        if pixel_value == 1
          pixel_array << [row_index, column_index]
        end
      end
    end
    return pixel_array
  end

  def output_pixel_locations
    puts "#{@pixel_array.length} pixels in image"
    puts "#{@pixel_array.inspect}"
  end

  def output_image
    @image_data.each do |row|
      puts row.join
    end
  end

  def blur(distance)
    get_pixel_coordinates.each do |row, column|
      self.blur_left_side(row, column, distance)
      self.blur_right_side(row,column, distance)
      self.blur_top(row,column, distance)
      self.blur_bottom(row,column, distance)
    end
  end

  def blur_left_side(row, column, distance)
    start_pos = column-distance
    diagonal_distance = 1
    if start_pos <= 0
      diagonal_distance = start_pos.abs
      start_pos = 0
    elsif start_pos > 0
      diagonal_distance = 0
    end
    last_pos = column

    i = start_pos
   
    while i < last_pos
      @image_data[row][i] = 1
      self.blur_top(row,i, diagonal_distance)
      self.blur_bottom(row, i, diagonal_distance)
      diagonal_distance += 1
      i += 1
    end
  end

  def blur_right_side(row, column, distance)
    start_pos = column+1
    last_pos = column+distance
    if last_pos > @image_data.first.length-1
      last_pos = @image_data.first.length-1
    end

    i = start_pos
    diagonal_distance = distance -1
    while i <= last_pos
      @image_data[row][i] = 1

      self.blur_top(row,i, diagonal_distance)
      self.blur_bottom(row, i, diagonal_distance)
      diagonal_distance -= 1
      i += 1
    end
  end

  def blur_top(row,column, distance)
    start_row_pos = row-1
    last_row_pos = row-distance
    if last_row_pos < 0
      last_row_pos = 0
    end

    i = start_row_pos
    while i >= last_row_pos
      @image_data[i][column] = 1
      i -= 1
    end
  end

  def blur_bottom(row,column,distance)
    start_row_pos = row+1
    last_row_pos = row+distance
    
    if last_row_pos > @image_data.length-1
      last_row_pos = @image_data.length-1
    end 

    i = start_row_pos
    while i <= last_row_pos
      @image_data[i][column] = 1
      i += 1
    end
  end
end

data = Image.new([
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0]
])

data.output_image
data.blur(3)
puts "------------------------------"
data.output_image

puts "====================================="
  data = Image.new([
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0, 0, 1],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0]
  ])

  data.output_image
  data.blur(3)
  puts "------------------------------"
  data.output_image

puts "====================================="
  data = Image.new([
    [0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0]
  ])

  puts "------------------------------"

  data.output_image
  data.blur(3)
  puts "------------------------------"
  data.output_image
#data.image_data.each do |row|
#  puts "#{row}"
#end

# identify where the element is located and store coordinate values
#data.output_pixel_locations


# manipulate left/right elements horizontally
    # row_index, column_index - 1   && row_index, column_index + 1
#row = data.image_data[1]
#puts "#{row.inspect}"
#data.image_data[1][0] = 1
#data.image_data[1][2] = 1
#puts "#{row.inspect}"

# manipulate element on row above

# manipulate element on row above

# pixel edge case

# pixels where transformation blur intersects