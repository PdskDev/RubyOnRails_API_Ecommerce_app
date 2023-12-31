class AuthenticableTest < ActionDispatch::IntegrationTest

    setup do
    @user = users(:one)
    @authentication = MockController.new
    end

    test "doit récupérer l'utilisateur depuis le token" do
        @authentication.request.headers['Authorization'] = JsonWebToken.encode(user_id: @user.id)
        assert_not_nil @authentication.current_user
        assert_equal @user.id, @authentication.current_user.id
    end

    test "ne doit pas récupérer un utilisateur depuis un token vide" do
        @authentication.request.headers['Authorization'] = nil
        assert_nil @authentication.current_user
    end
    
end

class MockController
    include Authenticable
    attr_accessor :request

    def initialize
        mock_request = Struct.new(:headers)
        self.request = mock_request.new({})
    end
    
end