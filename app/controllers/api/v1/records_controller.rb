module Api
  module V1    
    class RecordsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_record, only: %i[ show update destroy ]

      def index
        @records = Record.all

        render json: @records
      end

      def show
        render json: @record
      end

      def create
        @record = current_user.records.build(record_params)

        if @record.save
          render json: @record, status: :created, location: @record
        else
          render json: @record.errors, status: :unprocessable_entity
        end
      end

      def update
        if @record.update(record_params)
          render json: @record
        else
          render json: @record.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @record.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_record
          @record = current_user.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def record_params
          params.require(:record).permit(:title, :year, :artist_id)
        end
    end
  end
end
