class MatchesController < ApplicationController
    def index

        matches = Match.all

        if matches
            render json: matches
        else
            render json: {error: "players don't exist"}
        end

    end
end
