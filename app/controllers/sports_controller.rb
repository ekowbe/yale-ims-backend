class SportsController < ApplicationController
    def index
        sports = Sport.all

        render json: sports
    end

    def show
        sport = Sport.find_by(id: params[:id])
        if sport
            render json: sport
        else
            render json: {error: "sport not found"}
        end
    end
end
