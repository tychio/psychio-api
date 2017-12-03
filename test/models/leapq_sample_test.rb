require 'test_helper'

class LeapqSampleTest < ActiveSupport::TestCase
  setup do
    leapqSample = leapq_samples(:one)
    @sample = leapqSample.get
  end

  test "get info" do
    assert_equal(@sample[:info][:first_name], 'firstn')
    assert_equal(@sample[:info][:last_name], 'lastn')
  end

  test "get language ids" do
    assert_equal(@sample[:languages][:level][:lang1], 11)
    assert_equal(@sample[:languages][:level][:lang2], 12)

    assert_equal(@sample[:languages][:time][:lang1], 12)
    assert_equal(@sample[:languages][:time][:lang2], 11)
  end

  test "get levels" do
    assert_equal(@sample[:levels][:lang1_reading_use], 45)
    assert_equal(@sample[:levels][:lang1_speaking_use], 35)
    assert_equal(@sample[:levels][:lang1_listening_use], 35)
    assert_equal(@sample[:levels][:lang1_writing_use], 20)

    assert_equal(@sample[:levels][:lang2_reading_use], 65)
    assert_equal(@sample[:levels][:lang2_speaking_use], 40)
    assert_equal(@sample[:levels][:lang2_listening_use], 40)
    assert_equal(@sample[:levels][:lang2_writing_use], 15)
  end
end
