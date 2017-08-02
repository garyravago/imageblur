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
          #puts "(#{row_index},#{column_index}) --> #{pixel_value}"
          pixel_array << [row_index, column_index] # add pixel location to pixel array instance variable
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
    self.blur_horizontal
    self.blur_vertical
  end

  def blur_horizontal
    # iterate through each pixel location
    @pixel_array.each_with_index do |row_array,row_index|

      row = row_array[0] # return row location
      left_blur = row_array[1] - 1  # return left blur column value
      right_blur = row_array[1] + 1 # return right blur column value

      @image_data[row][left_blur] = 1 unless left_blur < 0 # handle left blur edge case
      @image_data[row][right_blur] = 1 unless right_blur > @image_data.first.length - 1 # handle right blur edge case
      
      #print "Row #{row} - #{left_blur}\n"
      #print "Row #{row} - #{right_blur}\n"
    end
  end

  def blur_vertical
    # iterate through each pixel location
    @pixel_array.each_with_index do |row_array,row_index|

      column = row_array[1] # return fixed column
      row_top_blur = row_array[0] - 1 # return top row location
      row_bottom_blur = row_array[0] + 1 # return bottom row location

      if row_top_blur > 0 
        @image_data[row_top_blur][column] = 1
      end

      if row_bottom_blur <= @image_data.length-1
        @image_data[row_bottom_blur][column] = 1
      end
      
      #print "Row #{row_top_blur} - #{column}\n"
      #print "Row #{row_bottom_blur} - #{column}\n"
    end
  end

end

data = Image.new([
  [1, 0, 0, 0, 1],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [1, 0, 0, 0, 1]
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


#image = Image.new([
#  [0, 0, 0, 0],
#  [0, 1, 0, 0],
#  [0, 0, 0, 1],
#  [0, 0, 0, 0]
#])
#image.output_image
