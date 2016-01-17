require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end
  test "should get new" do
    get :new
    assert_response :success
  end
#测试edit和update动作时受到保护的
test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_redirected_to login_url
  end

test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to login_url
  end

#测试编辑其他用户资料不可行
test "should redirect edit when logged in as wrong user" do
  log_in_as(@other_user)
  get :edit, id: @user
  assert_redirected_to root_url
end

test "should redirect update when logged in as wrong user" do
  log_in_as(@other_user)
  patch :update, id: @user, user: { name: @user.name, email: @user.email }
  assert_redirected_to root_url
end

#测试管理员权限的用户删除和非管理员的用户删除功能
test "should redirect destroy when not logged in" do
  assert_no_difference 'User.count' do
    delete :destroy, id: @user
  end
  assert_redirected_to login_url
end

test "should redirect destroy when logged in as a non-admin" do
  log_in_as(@other_user)
  assert_no_difference 'User.count' do
    delete :destroy, id: @user
  end
  assert_redirected_to root_url
end

end
