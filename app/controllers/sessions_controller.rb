class SessionsController < ApplicationController

    protect_from_forgery with: :null_session, unless: -> { request.format.json? }
    skip_before_action :verify_authenticity_token
    
    # POST /login
    def create
        #logger.debug "Received parameters: #{params.inspect}"
        puts "Received params: #{params.inspect}"  # Registrar los parámetros recibidos
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: { message: "Ingreso Correcto", user: user }, status: :ok
        else
            render json: { error: "Usuario o Contraseña Inválida"}, status: :unauthorized
        end
    end
  
    # DELETE /logout
    def destroy
      session[:user_id] = nil
      render json: { message: "Cierre de sesión correcto" }, status: :ok
    end
  end

  private

def session_params
  params.require(:session).permit(:email, :password)
end