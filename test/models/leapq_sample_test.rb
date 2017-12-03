require 'test_helper'

class LeapqSampleTest < ActiveSupport::TestCase
  test "get info" do
    sample = LeapqSample.first
    sample_detail = sample.get
    assert_equal(sample_detail[:info][:first_name], 'firstn')
    assert_equal(sample_detail[:info][:last_name], 'lastn')
  end
end
