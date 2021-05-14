require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BirdWatcher
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :options]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

Rails.application.routes.draw do
  get '/birds' => 'birds#index'
  get '/birds/:id' => 'birds#show' # new
end

class BirdsController < ApplicationController
  def index
    birds = Bird.all
    render json: birds
  end
 
  def show
    bird = Bird.find_by(id: params[:id])
    render json: bird
  end
end