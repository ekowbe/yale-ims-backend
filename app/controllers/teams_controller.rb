class TeamsController < ApplicationController
    def show
        team = Team.find_by(id: params[:id])

        if team
            render json: team
        else
            render json: {error: "team not found"}
        end
    end

    
end
