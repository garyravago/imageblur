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

  def blur_image
    get_pixel_coordinates.each do |row, column|
      self.blur_left(row, column)
      self.blur_right(row,column)
      self.blur_top(row,column)
      self.blur_bottom(row,column)
    end
  end

  def blur_left(row, column)

      if column > 0 && @image_data[row][column-1]
        @image_data[row][column-1] = 1
      end
  end

  def blur_right(row, column)

    if @image_data[row][column + 1]
      @image_data[row][column + 1] = 1 
    end
  end

  def blur_top(row,column)
    
    if row > 0 && @image_data[row - 1][column]
      @image_data[row - 1][column] = 1
    end

  end

  def blur_bottom(row,column)

    if @image_data.length-1 >= row + 1

      @image_data[row + 1][column] = 1
    end    
  end

end

data = Image.new([
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0]
])

data.output_image
data.blur_image
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