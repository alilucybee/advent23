require 'rspec/autorun'
require './elf_cube_game'

describe 'elf_cube_game' do
  it 'possible? returns true if the cubes were possible for the game bag' do
    game1 = ElfCubeGame.new({ 1 => [{ blue: 3, red: 4 }, { red: 1, green: 2, blue: 6 }, { green: 2 }] })
    game2 = ElfCubeGame.new({ 2 => [{ blue: 1, green: 2 }, { red: 1, green: 3, blue: 4 }, { green: 1, blue: 1 }] })
    game3 = ElfCubeGame.new({ 3 => [{ blue: 6, red: 20, green: 8 }, { red: 4, green: 13, blue: 5 }, { green: 5, red: 1 }] })
    game4 = ElfCubeGame.new({ 4 => [{ blue: 6, red: 3, green: 1 }, { red: 6, green: 3 }, { green: 3, blue: 15, red: 14 }] })
    game5 = ElfCubeGame.new({ 5 => [{ blue: 1, red: 6, green: 3 }, { red: 1, green: 2, blue: 2 }] })
    expect(game1.possible?).to eq(true)
    expect(game2.possible?).to eq(true)
    expect(game3.possible?).to eq(false)
    expect(game4.possible?).to eq(false)
    expect(game5.possible?).to eq(true)
  end

  it 'minimum returns the smallest number of cubes that could be possible in a bag' do
    game1 = ElfCubeGame.new({ 1 => [{ blue: 3, red: 4 }, { red: 1, green: 2, blue: 6 }, { green: 2 }] })
    game2 = ElfCubeGame.new({ 2 => [{ blue: 1, green: 2 }, { red: 1, green: 3, blue: 4 }, { green: 1, blue: 1 }] })
    game3 = ElfCubeGame.new({ 3 => [{ blue: 6, red: 20, green: 8 }, { red: 4, green: 13, blue: 5 }, { green: 5, red: 1 }] })
    game4 = ElfCubeGame.new({ 4 => [{ blue: 6, red: 3, green: 1 }, { red: 6, green: 3 }, { green: 3, blue: 15, red: 14 }] })
    game5 = ElfCubeGame.new({ 5 => [{ blue: 1, red: 6, green: 3 }, { red: 1, green: 2, blue: 2 }] })
    expect(game1.minimum).to eq({ red: 4, green: 2, blue: 6 })
    expect(game2.minimum).to eq({ red: 1, green: 3, blue: 4 })
    expect(game3.minimum).to eq({ red: 20, green: 13, blue: 6 })
    expect(game4.minimum).to eq({ red: 14, green: 3, blue: 15 })
    expect(game5.minimum).to eq({ red: 6, green: 3, blue: 2 })
  end
end
