class FoosController < ApplicationController

  before_filter :new_foo

  def index
    @foos = Foo.find(:all)
  end

  def new
    @foo = Foo.new
  end

  def create
    @foo = Foo.new(params[:foo])
    if @foo.save
      flash[:notice] = "Successfully created foo."
      redirect_to @foo
    else
      render :action => params[:page]
    end
  end

  def change_theme
    session[:wufoo_theme_id] = params[:wufoo_theme][:id]
    # render :nothing => true
    
    render(:update) do |page|
    page << 'location.reload(true)'
  end
  end

  private
  def new_foo
    @foo = Foo.new
    if session[:wufoo_theme_id]
      @wufoo_theme = WufooTheme.find(session[:wufoo_theme_id])
    else
      @wufoo_theme = WufooTheme.new
    end
  end

end
