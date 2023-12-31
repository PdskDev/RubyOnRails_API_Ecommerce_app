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
        post api_v1_users_url, params: { user: { email: @user.email, password: 'Pass123'}}, 
        as: :json
    end
    assert_response :unprocessable_entity 
end

test 'doit mettre à jour un utilisateur' do
    patch api_v1_user_url(@user), 
    params: { user: { email: @user.email }}, 
    headers: { Authorization: JsonWebToken.encode(user_id:@user.id)},
    as: :json
    assert_response :success
end

test 'doit interdir la mise à jour de compte' do
    patch api_v1_user_url(@user), 
    params: { user: {email: @user.email}},
    as: :json
    assert_response :forbidden
end

test 'ne doit pas mettre à jour un utilisateur quand les paramètres envoyés sont erronés' do
    patch api_v1_user_url(@user), params: { user: { email: 'non_trouve', 
    password:'P@ss12345' } }, as: :json
    #assert_response :unprocessable_entity
    assert_response :forbidden
end

test 'doit supprimer un utilisateur' do
    assert_difference('User.count', -1) do
        delete api_v1_user_url(@user), 
        headers: { Authorization: JsonWebToken.encode(user_id:@user.id)}, 
        as: :json
    end
    assert_response :no_content
end

test 'doit interdir de supprimer un utilisateur' do
    assert_no_difference('User.count') do
        delete api_v1_user_url(@user), 
        as: :json
    end
    assert_response :forbidden
end

end

