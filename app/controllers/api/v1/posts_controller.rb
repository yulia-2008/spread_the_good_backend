class Api::V1::PostsController < ApplicationController
     skip_before_action :authorized, only: [:index]

        def index
          @posts = Post.all 
          render :json => @posts, :include => [:user, :helper, :comments => {:include => [:user]}]

          #render json: @posts, include: [:user, :comments ]
          # user -  who wrote post
          #render :json => @user, :include => [ :user_posts =>  {:include => [:helper, :comments => {:include => [:user]}]}] 
        end

        def show 
          @post = Post.find_by(id:params[:id])

          render json: @post, include: [ :comments, :users, :helper]
          #users - who wrote comments
        end

        def create
          @post = Post.create(post_params)
            render json: @post
          
        end
        
        
         def update 
         
         @post = Post.find_by(id:params[:id])
         @post.update(post_params)
         render json: @post
         end
 

        def destroy 
          @post = Post.find_by(id:params[:id])
          @post.destroy
        end
       
        private
       
        def post_params
          params.require(:post).permit(:title, :helper_id, :user_id, :description, :active, :image, :archived)
        end
end
# delete post_params: active