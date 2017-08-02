# spec/image_blur_2_spec.rb
require 'image'

describe Image do

  before do
    @sample_image = Image.new([
      [0, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 0, 1],
      [0, 0, 0, 0]
    ])
  end

  describe "pixel data" do
    
      it "gives the pixel location" do
        expect(@sample_image.pixel_array).to include([1,1])
        expect(@sample_image.pixel_array).to include([2,3])
        expect(@sample_image.pixel_array).not_to include([0,0])
      end

      it "has a value of 1 if it is a pixel" do
        expect(@sample_image.image_data[1][1]).to eql(1)
        expect(@sample_image.image_data[2][3]).to eql(1)
      end

      it "has a value of 0 if it is not a pixel" do
        expect(@sample_image.image_data[0][0]).to eql(0)
        expect(@sample_image.image_data[2][0]).to eql(0)
      end

  end

  describe "blur transformation" do
    context "pixels are not touching any edge" do

      before do
        @sample_image = Image.new([
          [0, 0, 0, 0],
          [0, 1, 0, 0],
          [0, 0, 1, 0],
          [0, 0, 0, 0]
        ])

        @sample_image.blur_image
      end
      
      it "changes the pixel's horizontal adjacent elements to 1" do
        expect(@sample_image.image_data[1][0]).to eql(1)
        expect(@sample_image.image_data[1][2]).to eql(1)
      end

      it "changes the pixel's vertical adjacent element to 1" do
        expect(@sample_image.image_data[1][2]).to eql(1)
        expect(@sample_image.image_data[3][2]).to eql(1)
      end
    end

    context "pixels are touching the edge" do

      before do
        @sample_image = Image.new([
          [0, 0, 0, 1],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [1, 0, 0, 0]
        ])

        @original_row_length = @sample_image.image_data.first.length
        @original_row_height = @sample_image.image_data.first.length
        @sample_image.blur_image
      end
      
      it "does not apply a blur transformation on horizontal edges" do
        @sample_image.image_data.each do |row|
          expect(row.length).to be <= @original_row_length
        end
      end

      it "does not apply a blur transformation on vertical edges" do
        expect(@sample_image.image_data.length).to be <= @original_row_height
      end
    end
  end
end
