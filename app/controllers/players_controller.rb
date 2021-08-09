class PlayersController < ApplicationController
    def index

        players = Player.all

        if players
            render json: players
        else
            render json: {error: "players don't exist"}
        end

    end
end
