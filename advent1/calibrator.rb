# frozen_string_literal: true

# advent code day 1
class Calibrator
  require 'JSON'
  require_relative './advent1_data'
  attr_reader :data

  def initialize
    @data = JSON.parse(File.read('./advent1_data.rb'))
  end

  WORD_DIGITS = {
    'one' => '1',
    'two' => '2',
    'three' => '3',
    'four' => '4',
    'five' => '5',
    'six' => '6',
    'seven' => '7',
    'eight' => '8',
    'nine' => '9'
  }.freeze

  def word_to_digit(val)
    updated_value = val
    Calibrator::WORD_DIGITS.each_key do |key|
      next unless updated_value.include?(key)

      updated_value = updated_value.gsub(key, key[0] + Calibrator::WORD_DIGITS[key] + key[-1])
    end
    updated_value
  end

  def digitize(val)
    converted_words = word_to_digit(val)
    all_numbers = converted_words.scan(/\d/)
    return 0 if all_numbers.empty?

    (all_numbers.first + all_numbers.last).to_i
  end

  def sum(vals)
    digitized_array = vals.map { |x| digitize(x) }
    digitized_array.sum
  end
end
