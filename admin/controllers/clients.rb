Evercare::Admin.controllers :clients do
  get :index do
    @title = "Clients"
    @clients = Client.all
    render 'clients/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'client')
    @client = Client.new
    render 'clients/new'
  end

  post :create do
    @client = Client.new(params[:client])
    if @client.save
      @title = pat(:create_title, :model => "client #{@client.id}")
      flash[:success] = pat(:create_success, :model => 'Client')
      params[:save_and_continue] ? redirect(url(:clients, :index)) : redirect(url(:clients, :edit, :id => @client.id))
    else
      @title = pat(:create_title, :model => 'client')
      flash.now[:error] = pat(:create_error, :model => 'client')
      render 'clients/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "client #{params[:id]}")
    @client = Client.find(params[:id])
    if @client
      render 'clients/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'client', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "client #{params[:id]}")
    @client = Client.find(params[:id])
    if @client
      if @client.update_attributes(params[:client])
        flash[:success] = pat(:update_success, :model => 'Client', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:clients, :index)) :
          redirect(url(:clients, :edit, :id => @client.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'client')
        render 'clients/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'client', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Clients"
    client = Client.find(params[:id])
    if client
      if client.destroy
        flash[:success] = pat(:delete_success, :model => 'Client', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'client')
      end
      redirect url(:clients, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'client', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Clients"
    unless params[:client_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'client')
      redirect(url(:clients, :index))
    end
    ids = params[:client_ids].split(',').map(&:strip)
    clients = Client.find(ids)
    
    if Client.destroy clients
    
      flash[:success] = pat(:destroy_many_success, :model => 'Clients', :ids => "#{ids.join(', ')}")
    end
    redirect url(:clients, :index)
  end
end
