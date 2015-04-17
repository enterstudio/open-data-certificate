require 'test_helper'

class ResponseSetsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "user can destroy their response_set" do
    @user = FactoryGirl.create(:user)
    @response_set = FactoryGirl.create(:response_set, :user => @user)

    sign_in @user

    assert_difference('ResponseSet.count', -1) do
      delete :destroy, use_route: :surveyor, id: @response_set.id
    end

    assert_redirected_to dashboard_path

  end


  test "another user can't destroy response_set" do
    @response_set = FactoryGirl.create(:response_set)

    # unconnected user
    sign_in FactoryGirl.create(:user)

    assert_no_difference('ResponseSet.count') do
      delete :destroy, use_route: :surveyor, id: @response_set.id
    end

    assert_response 302

  end


  test "user can publish their response_set" do
    @user = FactoryGirl.create(:user)
    @response_set = FactoryGirl.create(:response_set, :user => @user)

    sign_in @user

    post :publish, use_route: :surveyor, id: @response_set.id

    assert_redirected_to dashboard_path

    @response_set.reload
    assert @response_set.published?, "response set was published"

  end

  test "successful url resolves check" do
    @user = FactoryGirl.create(:user)
    @response_set = FactoryGirl.create(:response_set, :user => @user)

    sign_in @user

    url_check = mock('url')
    url_check.stubs(:valid?).returns(true)
    ODIBot.expects(:new).with('http://example.com/path').returns(url_check)

    post :resolve, use_route: :surveyor, id: @response_set.id, :url => 'http://example.com/path'

    assert_equal 'application/json', response.content_type
    assert_equal({'valid' => true}, JSON.parse(response.body))

  end

  test "failed url resolves check" do
    @user = FactoryGirl.create(:user)
    @response_set = FactoryGirl.create(:response_set, :user => @user)

    sign_in @user

    url_check = mock('url')
    url_check.stubs(:valid?).returns(false)
    ODIBot.expects(:new).with('http://example.com/path').returns(url_check)

    post :resolve, use_route: :surveyor, id: @response_set.id, :url => 'http://example.com/path'

    assert_equal 'application/json', response.content_type
    assert_equal({'valid' => false}, JSON.parse(response.body))
  end

end
