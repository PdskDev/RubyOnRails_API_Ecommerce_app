require "test_helper"

class Api::V1::TokensControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
  end

  test 'doit récupérer un token JWt' do
    post api_v1_tokens_url, params: {user: { email: @user.email, password: 'Password@123'}}, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['token']
  end

  test 'ne doit pas obtenir un token JWT' do
    post api_v1_tokens_url, params: {user: { email: @user.email, password: 'Password@12345'}}, as: :json
    assert_response :unauthorized
  end


end
