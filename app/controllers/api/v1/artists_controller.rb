module Api
  module V1
    class ArtistsController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_artist, only: [:show, :update, :destroy]

      def index
        @artists = Artist.all

        render json: @artists
      end

      def show
        render json @artist
      end

      def create
        @artist = Artist.new(artist_params)
        
        if @artist.save
          render json: @artist, status: :created
        else
          render json: @artist.errors, status: :unprocessable_entity
        end
      end

      def update
        if @artist.update(artist_params)
          render json: @artist
        else
          render json: @artist.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @artist.destroy
      end

      private
      def set_artist
        @artist = Artist.find(params[:id])
      end

      def artist_params 
        params.require(:artist).permit(:name)
      end
    end
  end
end