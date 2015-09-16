require_relative '../blur'

describe Image do
  it 'returns the correct output' do
    input_output_table = {
      [
        [0, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 1],
        [0, 0, 0, 0]
      ] =>
      "0100\n1111\n0111\n0001",
      [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 0, 0, 0]
      ] =>
      "0000\n0000\n1000\n1100"
    }
    input_output_table.each do |input, output|
      image = Image.new(input)
      image.blur
      expect(image.to_s).to eq output
    end
  end

  describe 'helper methods' do
    let(:image) { Image.new([[0, 0], [0, 0]]) }
    describe '#height' do
      it 'returns the height of the image' do
        expect(image.height).to eq 2
      end
    end

    describe '#width' do
      it 'returns the width of the image' do
        expect(image.width).to eq 2
      end
    end

    describe '#adjacent_pixels' do
      it 'should return valid adjacent pixels' do
        expect(image.adjacent_pixels([0, 0])).to eq [[0, 1], [1, 0]]
      end
    end

    describe '#valid_index' do
      it 'returns false for invalid indexes' do
        expect(image.valid_index?([-1, 0])).to be_falsey
      end
    end
  end
end
