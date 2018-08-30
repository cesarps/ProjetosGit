require 'test_helper'

class AgendamentosControllerTest < ActionController::TestCase
  setup do
    @agendamento = agendamentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agendamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agendamento" do
    assert_difference('Agendamento.count') do
      post :create, :agendamento => @agendamento.attributes
    end

    assert_redirected_to agendamento_path(assigns(:agendamento))
  end

  test "should show agendamento" do
    get :show, :id => @agendamento.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @agendamento.to_param
    assert_response :success
  end

  test "should update agendamento" do
    put :update, :id => @agendamento.to_param, :agendamento => @agendamento.attributes
    assert_redirected_to agendamento_path(assigns(:agendamento))
  end

  test "should destroy agendamento" do
    assert_difference('Agendamento.count', -1) do
      delete :destroy, :id => @agendamento.to_param
    end

    assert_redirected_to agendamentos_path
  end
end
