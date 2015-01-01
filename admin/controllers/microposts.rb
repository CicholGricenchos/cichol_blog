CicholBlog::Admin.controllers :microposts do
  get :index do
    @title = "Microposts"
    @microposts = Micropost.all
    render 'microposts/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'micropost')
    @micropost = Micropost.new
    render 'microposts/new'
  end

  post :create do
    @micropost = Micropost.new(params[:micropost])
    if @micropost.save
      @title = pat(:create_title, :model => "micropost #{@micropost.id}")
      flash[:success] = pat(:create_success, :model => 'Micropost')
      params[:save_and_continue] ? redirect(url(:microposts, :index)) : redirect(url(:microposts, :edit, :id => @micropost.id))
    else
      @title = pat(:create_title, :model => 'micropost')
      flash.now[:error] = pat(:create_error, :model => 'micropost')
      render 'microposts/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "micropost #{params[:id]}")
    @micropost = Micropost.find(params[:id])
    if @micropost
      render 'microposts/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'micropost', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "micropost #{params[:id]}")
    @micropost = Micropost.find(params[:id])
    if @micropost
      if @micropost.update_attributes(params[:micropost])
        flash[:success] = pat(:update_success, :model => 'Micropost', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:microposts, :index)) :
          redirect(url(:microposts, :edit, :id => @micropost.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'micropost')
        render 'microposts/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'micropost', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Microposts"
    micropost = Micropost.find(params[:id])
    if micropost
      if micropost.destroy
        flash[:success] = pat(:delete_success, :model => 'Micropost', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'micropost')
      end
      redirect url(:microposts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'micropost', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Microposts"
    unless params[:micropost_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'micropost')
      redirect(url(:microposts, :index))
    end
    ids = params[:micropost_ids].split(',').map(&:strip)
    microposts = Micropost.find(ids)
    
    if Micropost.destroy microposts
    
      flash[:success] = pat(:destroy_many_success, :model => 'Microposts', :ids => "#{ids.to_sentence}")
    end
    redirect url(:microposts, :index)
  end
end
