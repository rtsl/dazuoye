require 'test_helper'

class ZhitiaosInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  test "zhitiao interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
# 无效的提交
    assert_no_difference 'Zhitiao.count' do
      post zhitiaos_path, zhitiao: { content: "" }
      end
    assert_select 'div#error_explanation'
# 有效提交
    content = "This zhitiao really ties the room together"
    assert_difference 'Zhitiao.count', 1 do
      end
    post zhitiaos_path, zhitiao: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
# 删除纸条
    assert_select 'a', text: 'delete'
    first_zhitiao = @user.zhitiaos.paginate(page: 1).first
    assert_difference 'Zhitiao.count', -1 do
      delete zhitiao_path(first_zhitiao)
      end
# 访问其他用户页面
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
end
