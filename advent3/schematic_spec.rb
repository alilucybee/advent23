require 'rspec/autorun'
require 'JSON'
require './schematic'


describe 'schematic' do
    sample = [
      '467..114..',
      '...*......',
      '..35..633.',
      '......#...',
      '617*......',
      '.....+.58.',
      '..592.....',
      '......755.',
      '...$.*....',
      '.664.598..'
    ]

    it 'returns the sample engine data' do
      schematic = Schematic.new(sample)
      expect(schematic.data.length).to eq(10)
      expect(schematic.data[0].length).to eq(10)
    end

    it 'returns the puzzle engine data' do
      puzzle_data = JSON.parse(File.read('./data.rb'))
      schematic = Schematic.new(puzzle_data)
      expect(schematic.data.length).to eq(140)
      expect(schematic.data[0].length).to eq(140)
    end

    it 'part_numbers returns an array of sample numbers adjacent to a symbol' do
      schematic = Schematic.new(sample)
      expected_result = [467, 35, 633, 617, 592, 755, 664, 598]
      expect(schematic.part_numbers).to eq(expected_result)
    end

    it 'sum_part_numbers returns the sum of all sample numbers adjacent to a symbol' do
      schematic = Schematic.new(sample)
      expect(schematic.sum_part_numbers).to eq(4361)
    end

    it 'sum_part_numbers returns the sum of all the puzzle data numbers adjacent to a symbol' do
      puzzle_data = JSON.parse(File.read('./data.rb'))
      schematic = Schematic.new(puzzle_data)
      expect(schematic.sum_part_numbers).to eq(324666) # too low sad face
    end
end
