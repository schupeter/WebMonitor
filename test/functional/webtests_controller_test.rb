require 'test_helper'

class WebtestsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:webtests)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_webtest
    assert_difference('Webtest.count') do
      post :create, :webtest => { }
    end

    assert_redirected_to webtest_path(assigns(:webtest))
  end

  def test_should_show_webtest
    get :show, :id => webtests(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => webtests(:one).id
    assert_response :success
  end

  def test_should_update_webtest
    put :update, :id => webtests(:one).id, :webtest => { }
    assert_redirected_to webtest_path(assigns(:webtest))
  end

  def test_should_destroy_webtest
    assert_difference('Webtest.count', -1) do
      delete :destroy, :id => webtests(:one).id
    end

    assert_redirected_to webtests_path
  end
end
