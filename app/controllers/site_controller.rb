class SiteController < ApplicationController
  layout 'site', :except => [:key, :permalink]

  before_filter :authorize_web
  before_filter :set_locale
  before_filter :require_user, :only => [:edit]

  def index
    @reload = true
    @classes = if params[:class].nil? then [] else params[:class].keys end
    @main_class = OntologyClass.find_by_name("Activity")
    if !params[:time].nil? then
      start = params[:day].to_i * Interval::DAY + params[:hour].to_i * 60 + params[:min].to_i * 10
      stop = start + params[:duration_hour].to_i * 60 + params[:duration_min].to_i * 10
      @interval = Interval.new(:start => start, :stop => stop)
    end
    # remember values for form
    @time = params[:time]
    @day = params[:day]
    if @day.nil? then @day = Date.today.wday-1 end
    @hour = params[:hour]
    if @hour.nil? then @hour = Time.now.hour end
    @min = params[:min]
    if @min.nil? then @min = Time.now.min / 10 end
    @duration_hour = params[:duration_hour]
    if @duration_hour.nil? then @duration_hour = 1 end
    @duration_min = params[:duration_min]
    if @duration_min.nil? then @duration_min = 0 end
  end

  def export
    render :action => 'index'
  end

  def permalink
    lon, lat, zoom = ShortLink::decode(params[:code])
    new_params = params.clone
    new_params.delete :code
    if new_params.has_key? :m
      new_params.delete :m
      new_params[:mlat] = lat
      new_params[:mlon] = lon
    else
      new_params[:lat] = lat
      new_params[:lon] = lon
    end
    new_params[:zoom] = zoom
    new_params[:controller] = 'site'
    new_params[:action] = 'index'
    redirect_to new_params
  end

  def key
    expires_in 7.days, :public => true
  end

  def edit
    editor = params[:editor] || @user.preferred_editor || DEFAULT_EDITOR

    if editor == "remote"
      render :action => :index
    else
      # Decide on a lat lon to initialise potlatch with. Various ways of doing this
      if params['lon'] and params['lat']
        @lon = params['lon'].to_f
        @lat = params['lat'].to_f
        @zoom = params['zoom'].to_i

      elsif params['mlon'] and params['mlat']
        @lon = params['mlon'].to_f
        @lat = params['mlat'].to_f
        @zoom = params['zoom'].to_i

      elsif params['gpx']
        @lon = Trace.find(params['gpx']).longitude
        @lat = Trace.find(params['gpx']).latitude

      elsif cookies.key?("_osm_location")
        @lon, @lat, @zoom, layers = cookies["_osm_location"].split("|")

      elsif @user and !@user.home_lon.nil? and !@user.home_lat.nil?
        @lon = @user.home_lon
        @lat = @user.home_lat

      else
        #catch all.  Do nothing.  lat=nil, lon=nil
        #Currently this results in potlatch starting up at 0,0 (Atlantic ocean).
      end

      @zoom = '14' if @zoom.nil?
    end
  end
end
