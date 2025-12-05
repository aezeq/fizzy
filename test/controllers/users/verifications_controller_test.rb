require "test_helper"

class Users::VerificationsControllerTest < ActionDispatch::IntegrationTest
  test "create verifies the user" do
    user = users(:david)
    user.update_column(:verified_at, nil)
    sign_in_as user

    assert_not user.verified?

    post users_verifications_path

    assert_response :ok
    assert user.reload.verified?
  end
end
