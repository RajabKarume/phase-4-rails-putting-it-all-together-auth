class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    # rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        user = User.find(session[:user_id])
        render json: Recipe.all, status: 200
    end
    def create
        user = User.find(session[:user_id])
        recipe = Recipe.create(user_id: user.id, title: recipe_params[:title], instructions: recipe_params[:instructions], minutes_to_complete: recipe_params[:minutes_to_complete])
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: 422
        end
    end

    private
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end
    def record_not_found
        render json: { errors: ["Unauthorized"] }, status: 401
    end
    # def record_invalid(invalid)
    #     render json: { errors: invalid.record.errors.full_messages }, status: 422
    # end
end
