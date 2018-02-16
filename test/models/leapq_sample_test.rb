require 'test_helper'

class LeapqSampleTest < ActiveSupport::TestCase
  setup do
    leapqSample = leapq_samples(:one)
    @sample = leapqSample.get
  end

  test "get info" do
    assert_equal(@sample[:info][:name], 'firstn')
    assert_equal(@sample[:info][:code], 'A01')
  end

  test "get language ids" do
    assert_equal(11, @sample[:languages][:level][:lang1])
    assert_equal(12, @sample[:languages][:level][:lang2])

    assert_equal(12, @sample[:languages][:time][:lang1])
    assert_equal(11, @sample[:languages][:time][:lang2])
  end

  test "get levels" do
    levels = @sample[:levels]
    assert_equal(45, levels[:lang1_reading_use])
    assert_equal(35, levels[:lang1_speaking_use])
    assert_equal(35, levels[:lang1_listening_use])
    assert_equal(20, levels[:lang1_writing_use])

    assert_equal(65, levels[:lang2_reading_use])
    assert_equal(40, levels[:lang2_speaking_use])
    assert_equal(40, levels[:lang2_listening_use])
    assert_equal(15, levels[:lang2_writing_use])
  end

  test "get ages" do
    ages = @sample[:ages]
    assert_equal(10, ages[:lang1_start_age])
    assert_equal(25, ages[:lang1_learn_age])
    assert_equal(40, ages[:lang1_l_instruction_age])
    assert_equal(65, ages[:lang1_c_instruction_age])
    
    assert_equal(30, ages[:lang2_start_age])
    assert_equal(15, ages[:lang2_learn_age])
    assert_equal(35, ages[:lang2_l_instruction_age])
    assert_equal(45, ages[:lang2_c_instruction_age])
  end

  test "get scores" do
    scores = @sample[:scores]
    assert_equal(55, scores[:lang1_speaking_self])
    assert_equal(70, scores[:lang1_listening_self])
    assert_equal(25, scores[:lang1_reading_self])

    assert_equal(20, scores[:lang2_speaking_self])
    assert_equal(45, scores[:lang2_listening_self])
    assert_equal(30, scores[:lang2_reading_self])
  end
end
