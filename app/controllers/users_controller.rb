class UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    def show
        user = User.find_by(id: session[:user_id])
        if user.nil?
            render json: { error: 'Not authorized' }, status: 401
        else
            render json: user, status: 201
        end
    end

    private
    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
end
