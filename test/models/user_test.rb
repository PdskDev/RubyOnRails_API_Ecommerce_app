require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'utilisateur avec email valide doit être valide' do
    user_email_valide = User.new(email: 'user@usertest.com', password_digest: 'Pass123')
    assert user_email_valide.valid?
  end

  test 'utilisateur avec email invalide doit être invalide' do
    user_email_invalide = User.new(email: 'user_usertest.com', password_digest: 'Pass123')
    assert_not user_email_invalide.valid?
  end

  test 'utilisateur avec email dupliqué est invalide' do
    user_email_duplique = User.new(email: 'admin@nadetdev.com', password_digest: 'Pass123')
    assert_not user_email_duplique.valid?
  end

  test 'utilisateur avec mot de passe invalide' do
    user_password_invalid = User.new(email: 'jmb@nadetdev.com', password_digest: 'Pass1')
    assert_not user_password_invalid.valid?
  end
end
