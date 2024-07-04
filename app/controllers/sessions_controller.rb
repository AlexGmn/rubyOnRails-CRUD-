class SessionsController < ApplicationController

    protect_from_forgery with: :null_session, unless: -> { request.format.json? }
  
    # POST /login
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: { message: "Ingreso Correcto", user: user }, status: :ok
        else
            render json: { error: "Usuario o Contraseña Inválida" }, status: :unauthorized
        end
    end
  
    # DELETE /logout
    def destroy
      session[:user_id] = nil
      render json: { message: "Cierre de sesión correcto" }, status: :ok
    end
  end