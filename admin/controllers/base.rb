AdminFramework::Admin.controllers :base do
  get :index, :map => "/" do
    @search = params[:search]
    render "base/index"
  end
end
