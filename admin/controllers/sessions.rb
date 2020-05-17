AdminFramework::Admin.controllers :sessions do
  $title = "Sign In - Account";
  $title_login = "Sign in Account";
  $title_login_description = "Enter your username and password and you will be a administrator";
  get :new do
    @title = $title;
    @title_login = $title_login;
    @title_login_description = $title_login_description;
    render "/sessions/new", nil, :layout => false
  end

  post :create do
    @title = $title;
    @title_login = $title_login;
    @title_login_description = $title_login_description;
    if account = Account.authenticate(params[:email], params[:password])
      set_current_account(account)
      redirect url(:base, :index)
    elsif Padrino.env == :development && params[:bypass]
      account = Account.first
      set_current_account(account)
      redirect url(:base, :index)
    else
      params[:email] = h(params[:email])
      flash.now[:error] = pat('login.error')
      render "/sessions/new", nil, :layout => false
    end
  end

  delete :destroy do
    @title = $title;
    @title_login = $title_login;
    @title_login_description = $title_login_description;
    set_current_account(nil)
    redirect url(:sessions, :new)
  end
end
