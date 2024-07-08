class UsersController < ApplicationController

    protect_from_forgery with: :null_session
    
    before_action :authorize, except: [:create]

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
      logger.debug "Received parameters: #{params.inspect}"
      
      @user = User.new(user_params)
      if @user.save
        #if @user.approved
          render json: @user, status: :created
        #else
        #  render json: { error: "Usuario No Aprobado." }, status: :forbidden
        #end
      else
          print (user_params)
          render json:  { errors: @user_params }, status: :unprocessable_entity
          
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
      params.require(:user).permit(:nombre, :apellido, :email, :password, :username)
    end

    def json_request?
        request.format.json?
    end
  end
  
