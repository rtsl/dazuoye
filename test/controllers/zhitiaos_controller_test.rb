require 'test_helper'

class ZhitiaosControllerTest < ActionController::TestCase


#对纸条操作的测试
def setup
  @micropost = microposts(:orange)
end

test "should redirect create when not logged in" do
  assert_no_difference 'Micropost.count' do
    post :create, micropost: { content: "Lorem ipsum" }
  end
  assert_redirected_to login_url
end

test "should redirect destroy when not logged in" do
  assert_no_difference 'Micropost.count' do
    delete :destroy, id: @micropost
  end
  assert_redirected_to login_url
end

#测试用户不可以删除其他用户的纸条
test "should redirect destroy for wrong zhitiao" do
  log_in_as(users(:michael))
  zhitiao = zhitiaos(:ants)
  assert_no_difference 'Zhitiao.count' do
    delete :destroy, id: zhitiao
  end
  assert_redirected_to root_url
end


end
