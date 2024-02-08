module Api
  class CarsController < ApplicationController
    before_action :set_car, only: %i[show update destroy]

    def index
      @cars = Car.with_attached_images.order(created_at: :desc).all
      render json: @cars.as_json(methods: [:image_urls])
    end

    def show
      render json: @car.as_json(include: :images).merge(
        images: @car.images.map do |_images|
                  url_for(image)
                end
      )
    end

    def create
      @car = Car.new(car_params)
      if @car.save
        render json: @car, status: :created
      else
        render json: @car.errors, status: :unprocessable_entity
      end
    end

    def update
      if @car.update(car_params)
        render json: @car
      else
        render json: @car.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @car.destroy
    end

    private

    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:make, :model, :year, :price, images: [])
      # .tap do |whitelisted|
      # 	whitelisted[:images] = params[:car][:images].select do |image|
      # 		image.content_type.in?(%w(image/jpeg image/png))
      # 	end
      # end
    end
  end
end
