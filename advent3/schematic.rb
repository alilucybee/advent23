# frozen_string_literal: true

# advent code day 3 - check what numbers are next to a symbol
class Schematic

  attr_reader :data
  require 'byebug'

  def initialize(data)
    @data = data
  end

  def is_match?(string, index)
    return unless string[index]
    string[index].match?(/\W/) && string[index] != "."
  end

  def part_numbers
    parts_array = []
    data.each_with_index do | string, index |
      number_array = string.scan(/\d+/)
      if number_array.length > 0
        number_array.each do | number|
          # get the indexes that we need
          start_index_of_number = string.index(number)
          end_index_of_number = string.index(number) + number.length - 1
          number_is_at_start = start_index_of_number === 0
          number_is_at_end = end_index_of_number === string.length - 1

          # first check if previous or next character is a symbol
          if !number_is_at_start && is_match?(string, start_index_of_number - 1)
            parts_array.push(number.to_i) 
            break
          end

          if !number_is_at_end && is_match?(string, end_index_of_number + 1)
            parts_array.push(number.to_i) 
            break
          end

          # then check if previous or next line with same or previous or next index character is a symbol
          index_start = number_is_at_start ? 0 : start_index_of_number - 1
          index_end = number_is_at_end ? end_index_of_number : end_index_of_number + 1
          indexes_to_check = (index_start..index_end).to_a
          previous_string = index === 0 ? nil : data[index - 1]
          next_string = index === data.length - 1 ? nil : data[index + 1]
          split_previous_string = previous_string&.chars
          split_next_string = next_string&.chars

          indexes_to_check.each do | number_index |
            if split_previous_string && is_match?(split_previous_string, number_index)
              parts_array.push(number.to_i) 
              break
            end
            if split_next_string && is_match?(split_next_string, number_index)
              parts_array.push(number.to_i)
              break
            end
          end
        end
      end
    end
    parts_array
  end

  def sum_part_numbers
    part_numbers.sum
  end
end