# frozen_string_literal: true

# advent code day 2 - check if a game is possible for the bag
class ElfCubeGame
  require 'JSON'
  require_relative './puzzle_data'
  attr_reader :cubes, :bag

  COLOURS = %i[red green blue].freeze

  def initialize(cubes)
    @cubes = cubes
    @bag = { red: 12, green: 13, blue: 14 }
  end

  def possible?
    cubes.values.pop.each do |cube_set|
      COLOURS.each do |colour|
        return false if cube_set.key?(colour) && cube_set[colour] > bag[colour]
      end
    end
    true
  end

  def minimum
    # [{ blue: 3, red: 4 }, { red: 1, green: 2, blue: 6 }, { green: 2 }]
    min_cubes = { blue: 0, red: 0, green: 0 }
    cubes.values.pop.each do |cube_set|
      COLOURS.each do |colour|
        min_cubes[colour] = cube_set[colour] if cube_set.key?(colour) && cube_set[colour] > min_cubes[colour]
      end
    end
    min_cubes
  end
end
