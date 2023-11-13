require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
 setup do
  @user = users(:one)
 end

 test 'doit afficher un utilisateur' do
  get api_v1_user_url(@user), as: :json
  assert_response :success
  json_response = JSON.parse(self.response.body)
  assert_equal @user.email, json_response['email']
 end

 test 'doit créer un utilisateur' do
    assert_difference('User.count') do
        post api_v1_users_url, params: { user: { email: 'test@test.com', password: 'Pass12345', 
        password_confirmation: 'Pass12345' } }, as: :json
    end
    assert_response :created
end

test 'ne doit pas créer un nouvel utilisateur avec un email existant' do
    assert_no_difference('User.count') do
        post api_v1_users_url, params: { user: { email: @user.email, password: 'Pass123'}}, as: :json
    end
    assert_response :unprocessable_entity 
end

test 'doit mettre à jour un utilisateur' do
    patch api_v1_user_url(@user), params: { user: { email: @user.email, 
    password: 'update12345' } }, as: :json
    assert_response :success
end

test 'ne doit pas mettre à jour un utilisateur quand les paramètres envoyés sont erronés' do
    patch api_v1_user_url(@user), params: { user: { email: 'non_trouve', 
    password:'P@ss12345' } }, as: :json
    assert_response :unprocessable_entity
end

end

