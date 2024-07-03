class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, if: :json_request?

    protect_from_forgery with: :null_session

    before_action :set_user, only: [:show, :update, :destroy]
  
    # GET /users
    def index
      @users = User.all
      render json: @users
    end
  
    # GET /users/:id
    def show
      render json: @user
    end
  
    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /users/:id
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /users/:id
    def destroy
      @user.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:username, :nombre, :apellido, :email, :password, :password_confirmation, :approved)
    end

    def json_request?
        request.format.json?
    end
  end
  
