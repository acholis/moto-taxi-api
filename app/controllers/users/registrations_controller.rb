# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
    before_action :set_user, only: [:create]
    before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up


    # POST /resource
    def create
        @user = User.new(configure_sign_up_params)
        
        if @user_exist.nil?
            if @user.save
                render json: {
                    messages: "Utilizador registado com sucesso",
                    success: true,
                    data: @user
                }, status: :unprocessable_entity
            else
                render json: {
                    messages: @user.errors,
                    success: false,
                    data: {}
                }, status: :unprocessable_entity
            end
        else
            render json: {
                messages: "Já existe uma conta com este nº de telefone",
                success: false,
                data: {}
            }, status: :unauthorized
        end

    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    # end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end

    private
        def set_user
            @user_exist = User.find_by_cell_phone(sign_up_params[:cell_phone])
        end

        def configure_sign_up_params
            params.require(:user).permit(:cell_phone, :password, :password_confirmation)
        end


end
