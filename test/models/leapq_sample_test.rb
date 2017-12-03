require 'test_helper'

class LeapqSampleTest < ActiveSupport::TestCase
  test "get" do
    sample = LeapqSample.first
    sample_detail = sample.get
    assert_equal(sample_detail[:first_name], 'firstn')
    assert_equal(sample_detail[:last_name], 'lastn')
  end
end
