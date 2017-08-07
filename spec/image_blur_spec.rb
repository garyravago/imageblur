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

  describe "blur transformation with arbitrary distance" do
    context "pixel or blur transformation does not go past any edges" do

      it "changes the pixel's left adjacent elements by 2" do
        @sample_image = Image.new([
          [0, 0, 0, 1, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0]
        ])

        @sample_image.blur(2)
        expect(@sample_image.image_data.first[1..2]).to eql([1,1])
      end

      it "changes the pixel's right adjacent elements by 2" do
        @sample_image = Image.new([
          [0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0]
        ])

        @sample_image.blur(2)
        expect(@sample_image.image_data.first[2..3]).to eql([1,1])    
      end

      it "changes the pixel's top adjacent elements by 2" do
        @sample_image = Image.new([
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0]
        ])

        @sample_image.blur(2)
        expect(@sample_image.image_data[1][1]).to eql(1)
        expect(@sample_image.image_data[2][1]).to eql(1) 
      end

     it "changes the pixel's bottom adjacent elements by 2" do
        @sample_image = Image.new([
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0]
        ])

        @sample_image.blur(2)
        expect(@sample_image.image_data[2][1]).to eql(1)
        expect(@sample_image.image_data[3][1]).to eql(1) 
      end      
    end

    context "pixel or blur transformation meets or exceeds edge" do
      
      it "does not apply a right blur when tranformation goes past right edge" do
        @sample_image = Image.new([
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 1, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ])

        @sample_image.blur(2)
        expect(@sample_image.image_data[2]).to eql([0,1,1,1,1]) 
      end

      it "does not apply a left blur transformation past the left edge" do
        @sample_image = Image.new([
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ])

        @sample_image.blur(2)
        expect(@sample_image.image_data[2]).to eql([1,1,1,1,0])
      end

      it "does not apply a top blur  when transformation goes past top edge" do
        @sample_image = Image.new([
          [0, 0, 0, 0, 0],
          [0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ])

        original_number_of_rows = @sample_image.image_data.length
        @sample_image.blur(2)

        expect(@sample_image.image_data.length).to eql(original_number_of_rows)
        expect(@sample_image.image_data[0][1]).to eql(1)
        expect(@sample_image.image_data[4][1]).not_to eql(1) 
      end

      it "does not apply bottom blur when transformation goes past bottom edge" do
        @sample_image = Image.new([
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 1, 0, 0],
          [0, 0, 0, 0, 0],
        ])

        original_number_of_rows = @sample_image.image_data.length
        @sample_image.blur(2)

        expect(@sample_image.image_data.length).to eql(original_number_of_rows)
        expect(@sample_image.image_data[4][2]).to eql(1)
        expect(@sample_image.image_data[0][2]).not_to eql(1) 
      end
    end
  end
end