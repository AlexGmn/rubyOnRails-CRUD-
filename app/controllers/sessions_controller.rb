class SessionsController < ApplicationController

    protect_from_forgery with: :null_session, unless: -> { request.format.json? }
    skip_before_action :verify_authenticity_token, only: [:create]
    
    # POST /login
    def create
        #logger.debug "Received parameters: #{params.inspect}"
        logger.info "Request body sessions_contr: #{request.body.read}"
        puts "Received params: #{params.inspect}"  # Registrar los parámetros recibidos

        user = User.find_by(email: params[:email])
        
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: { message: "Ingreso Correcto", user: user, token: generate_token(user.id) }, status: :ok
        else
            render json: { error: "Email o Contraseña Inválida"}, status: :unauthorized
        end
    end
  
    # DELETE /logout
    def destroy
      session[:user_id] = nil
      render json: { message: "Cierre de sesión correcto" }, status: :ok
    end

    private

    def session_params
      params.require(:session).permit(:email, :password)
    end

    def generate_token(user_id)
      JWT.encode({ user_id: user_id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base)
    end

end