require "test_helper"

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success

    get Avo.configuration.root_path
    assert_redirected_to '/session/new'

    post '/session', params: { email_address: users(:one).email_address, password: 'password' }
    # assert_redirected_to Avo.configuration.root_path
    get Avo.configuration.root_path
    assert_redirected_to '/'
    follow_redirect!
    assert_response :success

    users(:one).update(admin: true)
    get '/avo/resources/users'
    assert_response :success
  end
end
