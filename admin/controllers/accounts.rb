AdminFramework::Admin.controllers :accounts do
  get :index do
    @title = "Accounts"
    @total_rows_to_show=5
    @search = params[:search]
    if @search then
      @search_data=Account.where(Sequel.like(:name, '%'+@search+'%'))
      .or(Sequel.like(:surname, '%'+@search+'%'))
      .or(Sequel.like(:email, '%'+@search+'%'))
      .or(Sequel.like(:role, '%'+@search+'%'))
      if current_account.role != "admin"
        @search_data=@search_data.exclude(role: "admin")
      end
      @total_page=(@search_data.count.to_f / @total_rows_to_show).ceil;
      @total_page = 1 unless @total_page != 0
      @accounts = @search_data.page(params[:page], @total_rows_to_show).order(Sequel.desc(:id)).order_append(Sequel.desc(:role))
    else
      @search_data=Account
      if current_account.role != "admin"
        @search_data=@search_data.exclude(role: "admin")
      end
      @total_page=(@search_data.count.to_f / @total_rows_to_show).ceil;
      @total_page = 1 unless @total_page != 0
      @accounts = @search_data.page(params[:page], @total_rows_to_show).order(Sequel.desc(:id)).order_append(Sequel.desc(:role))
    end
    render 'accounts/index'
  end

  get :new do
    halt 403 unless current_account.role == "admin"
    @title = pat(:new_title, :model => 'account')
    @account = Account.new
    render 'accounts/new'
  end

  post :create do
    halt 403 unless current_account.role == "admin"
    if File.extname(params[:account]['avatar'])==".jpg" || File.extname(params[:account]['avatar'])==".jpeg" || File.extname(params[:account]['avatar'])==".png" then
    else
      if params[:account]['avatar'].empty? then
      else
        avatar_binary = params[:account]['avatar'].split(";base64,")
        params[:account]['avatar'] = Time.now.strftime("%d%m%Y%H%M")+rand(10..10000).to_s+"-avatar"+".png"
        File.open(Padrino.root("public/uploads/avatars/",params[:account]['avatar']), "wb") do |file|
          file.write(Base64.decode64(avatar_binary[1]))
        end
      end
    end
    @account = Account.new(params[:account])
    if (@account.save rescue false)
      @title = pat(:create_title, :model => "account #{@account.id}")
      flash[:success] = pat(:create_success, :model => 'Account')
      params[:save_and_continue] ? redirect(url(:accounts, :index)) : redirect(url(:accounts, :edit, :id => @account.id))
    else
      @title = pat(:create_title, :model => 'account')
      flash.now[:error] = pat(:create_error, :model => 'account')
      render 'accounts/new'
    end
  end

  get :edit, :with => :id do
    puts params[:id]
    puts current_account.id
    if current_account.role == "admin"

    else
      if(params[:id].to_s != current_account.id.to_s)
        halt 403
      end
    end
    @title = pat(:edit_title, :model => "account #{params[:id]}")
    @account = Account[params[:id]]
    if @account
      render 'accounts/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'account', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "account #{params[:id]}")
    if File.extname(params[:account]['avatar'])==".jpg" || File.extname(params[:account]['avatar'])==".jpeg" || File.extname(params[:account]['avatar'])==".png" then
    else
      if params[:account]['avatar'].empty? then
      else
        avatar_binary = params[:account]['avatar'].split(";base64,")
        params[:account]['avatar'] = Time.now.strftime("%d%m%Y%H%M")+rand(10..10000).to_s+"-avatar"+".png"
        File.open(Padrino.root("public/uploads/avatars/",params[:account]['avatar']), "wb") do |file|
          file.write(Base64.decode64(avatar_binary[1]))
        end
      end
    end
    @account = Account[params[:id]]
    if @account
      if @account.modified! && @account.update(params[:account])
        flash[:success] = pat(:update_success, :model => 'Account', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:accounts, :index)) :
          redirect(url(:accounts, :edit, :id => @account.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'account')
        render 'accounts/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'account', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    halt 403 unless current_account.role == "admin"
    @title = "Accounts"
    account = Account[params[:id]]
    if account
      if account != current_account && account.destroy
        flash[:success] = pat(:delete_success, :model => 'Account', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'account')
      end
      redirect url(:accounts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'account', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    if current_account.role == "admin"
      @title = "Accounts"
      unless params[:account_ids]
        flash[:error] = pat(:destroy_many_error, :model => 'account')
        redirect(url(:accounts, :index))
      end
      ids = params[:account_ids].split(',').map(&:strip)
      accounts = Account.where(:id => ids)

      if accounts.include? current_account
        flash[:error] = pat(:delete_error, :model => 'account')
      elsif accounts.destroy

        flash[:success] = pat(:destroy_many_success, :model => 'Accounts', :ids => "#{ids.join(', ')}")
      end
      redirect url(:accounts, :index)
    else
      halt 403
    end
  end
end
