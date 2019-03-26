require("minitest/autorun")
require('minitest/rg')
require_relative("../models/lead.rb")

class LeadTest < MiniTest::Test
  def setup()
    @lead = Lead.new({
      'last_updated' => Date.new(2011,03,03),
      'name' => 'UX Designer 1',
      'link' => 'www.bbc.co.uk',
      'summary' => 'Lorem ipsum',
      'comments' => 'Lorem ipsum'
      })
  end

  def test_save
    @lead.save
    assert_equal(2,@lead.id)
  end
  # def test_long_ago()
  #   result = @lead.long_ago
  #   assert_equal("over 7 years ago", result)
  # end
end
