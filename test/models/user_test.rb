require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'utilisateur avec email valide doit être valide' do
    userEmailValide = User.new(email: 'user@usertest.com', password_digest: 'Pass123')
    assert userEmailValide.valid?
  end

  test 'utilisateur avec email invalide doit être invalide' do
    userEmailInvalide = User.new(email: 'user_usertest.com', password_digest: 'Pass123')
    assert_not userEmailInvalide.valid?
  end

  test 'utilisateur avec email dupliqué est invalide' do
    userEmailDuplique = User.new(email: 'admin@nadetdev.com', password_digest: 'Pass123')
    assert_not userEmailDuplique.valid?
  end
end
