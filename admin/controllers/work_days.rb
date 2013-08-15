Hours::Admin.controllers :work_days do
  get :index do
    @title = "Work_days"
    @work_days = WorkDay.all
    render 'work_days/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'work_day')
    @work_day = WorkDay.new
    render 'work_days/new'
  end

  post :create do
    @work_day = WorkDay.new(params[:work_day])
    if (@work_day.save rescue false)
      @title = pat(:create_title, :model => "work_day #{@work_day.id}")
      flash[:success] = pat(:create_success, :model => 'WorkDay')
      params[:save_and_continue] ? redirect(url(:work_days, :index)) : redirect(url(:work_days, :edit, :id => @work_day.id))
    else
      @title = pat(:create_title, :model => 'work_day')
      flash.now[:error] = pat(:create_error, :model => 'work_day')
      render 'work_days/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "work_day #{params[:id]}")
    @work_day = WorkDay[params[:id]]
    if @work_day
      render 'work_days/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'work_day', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "work_day #{params[:id]}")
    @work_day = WorkDay[params[:id]]
    if @work_day
      if @work_day.modified! && @work_day.update(params[:work_day])
        flash[:success] = pat(:update_success, :model => 'Work_day', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:work_days, :index)) :
          redirect(url(:work_days, :edit, :id => @work_day.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'work_day')
        render 'work_days/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'work_day', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Work_days"
    work_day = WorkDay[params[:id]]
    if work_day
      if work_day.destroy
        flash[:success] = pat(:delete_success, :model => 'Work_day', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'work_day')
      end
      redirect url(:work_days, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'work_day', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Work_days"
    unless params[:work_day_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'work_day')
      redirect(url(:work_days, :index))
    end
    ids = params[:work_day_ids].split(',').map(&:strip)
    work_days = WorkDay.where(:id => ids)
    
    if work_days.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Work_days', :ids => "#{ids.to_sentence}")
    end
    redirect url(:work_days, :index)
  end
end
