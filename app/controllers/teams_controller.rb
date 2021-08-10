class TeamsController < ApplicationController
    
    def index
        teams = Team.all

        if teams
            render json: teams
        else
            render json: {error: "teams not found"}
        end
    end

    def show
        team = Team.find_by(id: params[:id])

        if team
            render json: team
        else
            render json: {error: "team not found"}
        end
    end

    
end
