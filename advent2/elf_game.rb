# frozen_string_literal: true

# advent code day 2 - parser for data
class ElfGame
  require_relative './elf_cube_game'
  require 'JSON'
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def parser
    data.map do |game|
      game_id = game[/(\d{1,3}):/].to_i
      cube_samples = []
      cube_strings = game[/:(.*$)/].split(';')
      cube_strings.each do |cube_string|
        cube_samples.push(
          {
            blue: cube_string[/(\d{1,2}) blue/].to_i,
            red: cube_string[/(\d{1,2}) red/].to_i,
            green: cube_string[/(\d{1,2}) green/].to_i
          }
        )
      end
      { game_id => cube_samples }
    end
  end

  def possible_games(parsed_games)
    possible_games = []
    parsed_games.each do |game|
      game = ElfCubeGame.new(game)
      possible_games.push(game.cubes) if game.possible?
    end
    possible_games
  end

  def sum_ids(parsed_games)
    keys = []
    parsed_games.map do |game|
      game.select { |key| keys.push(key) }
    end
    keys.sum
  end

  def sum_power_of_minimum_cubes(parsed_games)
    minimum_powers = []
    parsed_games.each do |game|
      game = ElfCubeGame.new(game)
      minimum_powers.push(game.minimum.values.inject(:*))
    end
    minimum_powers.sum
  end
end
