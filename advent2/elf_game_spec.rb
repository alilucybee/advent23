require 'rspec/autorun'
require './elf_game'

describe 'elf_game' do
  it 'parser parses strings into object with array values' do
    string_data = [
      'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
      'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
      'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
      'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
      'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green',
      'Game 6: 7 red, 1 green, 4 blue; 13 red, 11 blue; 6 red, 2 blue; 9 blue, 9 red; 4 blue, 11 red; 15 red, 1 green, 3 blue'
    ]

    expected_data = [
      { 1 => [{ blue: 3, red: 4, green: 0 }, { blue: 6, red: 1, green: 2 }, { blue: 0, red: 0, green: 2 }] },
      { 2 => [{ blue: 1, red: 0, green: 2 }, { blue: 4, red: 1, green: 3 }, {  blue: 1, red: 0, green: 1 }] },
      { 3 => [{ blue: 6, red: 20, green: 8 }, { blue: 5, red: 4, green: 13 }, { blue: 0, red: 1, green: 5 }] },
      { 4 => [{ blue: 6, red: 3, green: 1 }, { blue: 0, red: 6, green: 3 }, { blue: 15, red: 14, green: 3 }] },
      { 5 => [{ blue: 1, red: 6, green: 3 }, { blue: 2, red: 1, green: 2 }] },
      { 6 => [{ blue: 4, red: 7, green: 1 }, { blue: 11, red: 13, green: 0 }, { blue: 2, red: 6, green: 0 }, { blue: 9, red: 9, green: 0 }, { blue: 4, red: 11, green: 0 }, { blue: 3, red: 15, green: 1 }] }
    ]

    elf_game = ElfGame.new(string_data)
    parser = elf_game.parser
    expect(parser.length).to eq(6)
    expect(parser[0]).to eq(expected_data[0])
    expect(parser[1]).to eq(expected_data[1])
    expect(parser[2]).to eq(expected_data[2])
    expect(parser[3]).to eq(expected_data[3])
    expect(parser[4]).to eq(expected_data[4])
    expect(parser[5]).to eq(expected_data[5])
  end

  it 'parser parses puzzle_data correctly' do
    data = JSON.parse(File.read('./puzzle_data.rb'))
    elf_game = ElfGame.new(data)
    parser = elf_game.parser
    expected_game_2 = { 2 => [{ blue: 4, red: 7, green: 1 }, { blue: 11, red: 13, green: 0 }, { blue: 2, red: 6, green: 0 }, { blue: 9, red: 9, green: 0 }, { blue: 4, red: 11, green: 0 }, { blue: 3, red: 15, green: 1 }] }
    expect(parser.length).to eq(100)
    expect(parser[1]).to eq(expected_game_2)
  end

  it 'possible_games returns an array of possible games' do
    string_data = [
      'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
      'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
      'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
      'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
      'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
    ]
    elf_game = ElfGame.new(string_data)
    parsed_games = elf_game.parser
    possible_games = elf_game.possible_games(parsed_games)
    expected_possible_games = [
    { 1 => [{ blue: 3, red: 4, green: 0 }, { blue: 6, red: 1, green: 2 }, { blue: 0, red: 0, green: 2 }] },
    { 2 => [{ blue: 1, red: 0, green: 2 }, { blue: 4, red: 1, green: 3 }, {  blue: 1, red: 0, green: 1 }] },
    { 5 => [{ blue: 1, red: 6, green: 3 }, { blue: 2, red: 1, green: 2 }] }
    ]
    expect(possible_games).to eq(expected_possible_games)
  end

  it 'sum_ids returns a sum of object keys' do
    string_data = [
      'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
      'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
      'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
      'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
      'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
    ]
    elf_game = ElfGame.new(string_data)
    parsed_games = elf_game.parser
    sum_ids = elf_game.sum_ids(parsed_games)
    expect(sum_ids).to eq(15)
  end

  it 'sum_ids returns a sum of puzzle data' do
    data = JSON.parse(File.read('./puzzle_data.rb'))
    elf_game = ElfGame.new(data)
    parsed_games = elf_game.parser
    possible_games = elf_game.possible_games(parsed_games)
    sum_ids = elf_game.sum_ids(possible_games)
    expect(sum_ids).to eq(2268)
  end

  it 'sum_power_of_minimum_cubes returns the sum power of the minimum cubes in a set of games' do
    string_data = [
      'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
      'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
      'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
      'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
      'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
    ]
    elf_game = ElfGame.new(string_data)
    parsed_games = elf_game.parser
    expect(elf_game.sum_power_of_minimum_cubes(parsed_games)).to eq(2286)
  end

  it 'sum_power_of_minimum_cubes returns the sum power of the minimum cubes for the puzzle data' do
    data = JSON.parse(File.read('./puzzle_data.rb'))
    elf_game = ElfGame.new(data)
    parsed_games = elf_game.parser
    expect(elf_game.sum_power_of_minimum_cubes(parsed_games)).to eq(63542)
  end
end
