require 'test_helper'

class ZhitiaoTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @zhitiao = @user.zhitiaos.build(content: "Lorem ipsum")
  end

#对纸条模型的验证，包括其有效性等

test "should be valid" do
  assert @zhitiao.valid?
end

test "user id should be present" do
  @zhitiao.user_id = nil
  assert_not @zhitiao.valid?
end

test "content should be present" do
  @zhitiao.content = " "
  assert_not @zhitiao.valid?
end

#排序的验证
test "order should be most recent first" do
  assert_equal Zhitiao.first, zhitiaos(:most_recent)
end

end
