require 'rspec/autorun'
require './calibrator'

describe 'calibrator' do
  it 'data allows the full data set to be accessed' do
    c = Calibrator.new
    expect(c.data.first).to eq('eightqrssm9httwogqshfxninepnfrppfzhsc')
    expect(c.data.length).to eq(1000)
  end

  it 'word_to_digit converts number string into digit string' do
    c = Calibrator.new
    expect(c.word_to_digit('anineeightsevensixfivefourthreetwoonej')).to eq('an9ee8ts7ns6xf5ef4rt3et2oo1ej')
    expect(c.word_to_digit('nineightsevensixfivefourthreetwone')).to eq('n9e8ts7ns6xf5ef4rt3et2o1e')
    expect(c.word_to_digit('twoneighthreeightwo1')).to eq('t2o1e8t3e8t2o1')
    expect(c.word_to_digit('twooneeightthreeeighttwo1')).to eq('t2oo1ee8tt3ee8tt2o1')
  end

  it 'digitize returns 0 if no digits' do
    c = Calibrator.new
    expect(c.digitize('pqrstuvwx')).to eq(0)
  end

  it 'digitize returns the first and last digit when the string contains digits' do
    c = Calibrator.new
    expect(c.digitize('1abc2')).to eq(12)
    expect(c.digitize('1pqrstuvwx0')).to eq(10)
    expect(c.digitize('0pqrstuvwx1')).to eq(1)
    expect(c.digitize('pqr3stu8vwx')).to eq(38)
    expect(c.digitize('a1b2c3d4e5f')).to eq(15)
    expect(c.digitize('treb7uchet')).to eq(77)
  end

  it 'digitize handles digits when they are spelt as words' do
    c = Calibrator.new
    expect(c.digitize('two1nine')).to eq(29)
    expect(c.digitize('eightwothree')).to eq(83)
    expect(c.digitize('abcone2threexyz')).to eq(13)
    expect(c.digitize('xtwone3four')).to eq(24)
    expect(c.digitize('4nineeightseven2')).to eq(42)
    expect(c.digitize('zoneight234')).to eq(14)
    expect(c.digitize('7pqrstsixteen')).to eq(76)
    expect(c.digitize('twoneight')).to eq(28)
    expect(c.digitize('oneighthat')).to eq(18)
    expect(c.digitize('twone')).to eq(21)
  end

  it 'sum returns the sum total of an array of digitised strings' do
    c = Calibrator.new
    array1 = [
      '1abc2',
      'pqr3stu8vwx',
      'a1b2c3d4e5f',
      'treb7uchet'
    ]

    array2 = [
      'two1nine',
      'eightwothree',
      'abcone2threexyz',
      'xtwone3four',
      '4nineeightseven2',
      'zoneight234',
      '7pqrstsixteen'
    ]

    array3 = c.data

    expect(c.sum(array1)).to eq(142)
    expect(c.sum(array2)).to eq(281)
    expect(c.sum(array3)).to eq(53866)
  end
end
