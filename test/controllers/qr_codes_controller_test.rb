require "test_helper"

class QrCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get qr_codes_index_url
    assert_response :success
  end
end
