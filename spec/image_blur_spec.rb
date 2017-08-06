# spec/image_blur_2_spec.rb
require 'image'

describe Image do

  describe "pixel data" do
    
      it "gives the pixel location" do

        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 0, 1],
          [0, 0, 0, 0]
        ])

        expect(@sample_image.pixel_array).to include([1,1])
        expect(@sample_image.pixel_array).to include([2,3])
        expect(@sample_image.pixel_array).not_to include([0,0])
      end

      it "has a value of 1 if it is a pixel" do

        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 0, 1],
          [0, 0, 0, 0]
        ])

        expect(@sample_image.image_data[1][1]).to eql(1)
        expect(@sample_image.image_data[2][3]).to eql(1)
      end

      it "has a value of 0 if it is not a pixel" do

        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 0, 1],
          [0, 0, 0, 0]
        ])
        expect(@sample_image.image_data[0][0]).to eql(0)
        expect(@sample_image.image_data[2][0]).to eql(0)
      end

  end

  describe "blur transformation" do
    context "pixels are not touching any edge" do
      
      it "changes the pixel's left adjacent elements to 1" do

        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 1, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data[1][0]).to eql(1)
        expect(@sample_image.image_data[1][2]).to eql(1)
      end

      it "changes the pixel's right adjacent elements to 1" do

        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 1, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data[1][2]).to eql(1)
        expect(@sample_image.image_data[2][3]).to eql(1)
      end      

      it "changes the pixel's top adjacent element to 1" do

        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 1, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data[0][1]).to eql(1)
        expect(@sample_image.image_data[1][2]).to eql(1)
      end

      it "changes the pixel's bottom adjacent element to 1" do

        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 1, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data[2][1]).to eql(1)
        expect(@sample_image.image_data[3][2]).to eql(1)
      end
    end

    context "pixels are touching the edge" do
      
      it "applies a left blur transformation when pixel is on right edge" do

        @sample_image = Image.new([
          [0, 0, 0, 1],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data.first).to eql([0,0,1,1])
      end

      it "does not apply a right blur transformation when pixel is on right edge" do

        @sample_image = Image.new([
          [0, 0, 0, 1],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ])

        original_row_length = @sample_image.image_data.first.length
        @sample_image.blur_image

        expect(@sample_image.image_data.first.length).to eq(original_row_length)
      end
      it "applies a right blur transformation when pixel is on left edge" do
        @sample_image = Image.new([
          [1, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data.first).to eql([1,1,0,0]) 
      end

      it "does not apply a left blur transformation when pixel is on left edge" do
        @sample_image = Image.new([
          [1, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data.first).not_to eql([1,0,0,1]) 
      end

      it "applies a bottom blur transformation when pixel is on top edge" do
          @sample_image = Image.new([
          [1, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data[1]).to eql([1,0,0,0]) 
      end

      it "does not apply a top blur transformation when pixel is on top edge" do
        @sample_image = Image.new([
          [1, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ])

        original_number_of_rows = @sample_image.image_data.length
        @sample_image.blur_image

        expect(@sample_image.image_data.length).to eql(original_number_of_rows)
        expect(@sample_image.image_data.last).not_to eql([1,0,0,0]) 
      end

      it "applies a top blur transformation when pixel is on bottom edge" do
        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [1, 0, 0, 0]
        ])

        @sample_image.blur_image
        expect(@sample_image.image_data[2][0]).to eql(1) 
      end

      it "does not apply a bottom blur transformation when pixel is on bottem edge" do
        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [1, 0, 0, 0]
        ])

        original_number_of_rows = @sample_image.image_data.length
        @sample_image.blur_image

        expect(@sample_image.image_data.length).to eql(original_number_of_rows)
      end
    end
  end
end