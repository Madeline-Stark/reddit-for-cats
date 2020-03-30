class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
    # if we're coming to this action through a nested route, 
    if params[:user_id]
    #we only want to display that user's posts
      find_user
      if @user
        @posts = @user.posts
      else 
        flash[:alert] = "User doesn't exist"
        redirect_to posts_path
      end
    #if we're coming to this action normally, 
    else
    #we just want to display all posts
      @posts = Post.all
    end

    
  end

  def show
    
  end
  
  def new
    #if we're coming to this action from a nested route
    if params[:user_id]
      find_user
      if @user
        # preassociate post with user
        @post = @user.posts.build
      end
    else
      @post = Post.new
    end
  end

  def create 
    #if coming from nested route
    #create post associated with that user 
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else 
      render :edit 
    end
  end 

  def destroy 
    @post.destroy
    redirect_to posts_path
  end 

  private 

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def current_user
    User.first
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
  end


end
