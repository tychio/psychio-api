require 'test_helper'

class LeapqSampleTest < ActiveSupport::TestCase
  test "get info" do
    sample = LeapqSample.first
    sample_detail = sample.get
    assert_equal(sample_detail[:info][:first_name], 'firstn')
    assert_equal(sample_detail[:info][:last_name], 'lastn')
  end

  test "get language ids" do
    sample = LeapqSample.first
    sample_detail = sample.get
    assert_equal(sample_detail[:languages][:level][:lang1], 11)
    assert_equal(sample_detail[:languages][:level][:lang2], 12)

    assert_equal(sample_detail[:languages][:time][:lang1], 12)
    assert_equal(sample_detail[:languages][:time][:lang2], 11)
  end
end
