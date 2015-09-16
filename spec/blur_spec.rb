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
      check_blur(input, output, 1)
    end
  end

  it 'works for distance of 2' do
    input = [
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [1, 0, 0, 0]
    ]
    output = "0000\n1000\n1100\n1110"
    check_blur(input, output, 2)
  end

  it 'works for distance of 3' do
    input = [
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [1, 0, 0, 0]
    ]
    output = "1000\n1100\n1110\n1111"
    check_blur(input, output, 3)
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


    describe '#valid_index' do
      it 'returns false for invalid indexes' do
        expect(image.valid_index?([-1, 0])).to be_falsey
      end
    end
  end

  def check_blur(input, output, distance)
    image = Image.new(input)
    image.blur(distance)
    expect(image.to_s).to eq output
  end
end
