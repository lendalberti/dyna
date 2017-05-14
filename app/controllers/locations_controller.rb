class LocationsController < ApplicationController
  
  def index
    @locations = Location.all.order( 'created_at DESC' )
  end
  
  def create
    require 'json'
    require 'open-uri'

    api_key = 'AIzaSyBknf1lS852Qx1Mj3UYfE8DYcaHlTSv2xA'  # for project: 'Dyna Project'
    api_url = 'https://maps.googleapis.com/maps/api/geocode/json' 

    if params['address'].present?
      addr = params["address"].tr(' ','+')
      api_url += "?address=#{addr}&key=#{api_key}"

      contents = open( api_url ) { |f| f.read }
      data = JSON.parse(contents)

      if data['results'].any?
        data['results'].each do |d|
          loc = Location.new
          loc.address   = params["address"]
          loc.longitude = d['geometry']['location']['lng']
          loc.latitude  = d['geometry']['location']['lat']

          if loc.save
            logger.info("Geometry saved for [#{params["address"]}]")
            flash[:success] = 'Address located...'
          else 
            logger.warn "Couldn't save geometry for [#{params["address"]}] - error: #{loc.errors.messages}"
            flash[:warning] = "Couldn't save this address"
          end

        end
      else
        flash[:warning] = "Can't locate this address..."
      end
    end

    respond_to do |format|
      format.js
    end
  end
  


end

