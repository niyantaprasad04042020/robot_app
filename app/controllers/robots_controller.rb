class RobotsController < ApplicationController

  def orders
  	commands           = params[:command]
  	@location          = commands[0].split(",")
  	@x_axis            = @location[0].split(" ")[1].to_i
  	@y_axis            = @location[1].to_i
  	@initial_direction = @location[2]
  	commands.each do |command|
	  	case command
	    when "MOVE"
	      move()
	    when "LEFT"
	      left()
	    when "RIGHT"
	      right()
	    when "REPORT"
	    	@final_position = []
	    	report()
	    else
	      nil
	    end
	  end
  end

  def move
    case @initial_direction
    when "EAST"
    	@x_axis = @x_axis + 1
    when "WEST"
    	@x_axis = @x_axis - 1
    when "NORTH"
    	@y_axis = @y_axis + 1
    when "SOUTH"
    	@y_axis = @y_axis - 1
    else
    	nil
    end
  end 

  def right
  	case @initial_direction
  	when "EAST"
  		@initial_direction = "SOUTH"
  	when "WEST"
  		@initial_direction = "NORTH"
  	when "NORTH"
  		@initial_direction = "EAST"
  	when "SOUTH"
  		@initial_direction = "WEST"
  	else
      nil
  	end
  end

  def left
  	case @initial_direction
  	when "EAST"
  		@initial_direction = "NORTH"
  	when "WEST"
  		@initial_direction = "SOUTH"
  	when "NORTH"
  		@initial_direction = "WEST"
  	when "SOUTH"
  		@initial_direction = "EAST"
  	else
      nil
  	end
  end

  def report
    @final_position = [@x_axis, @y_axis, @initial_direction]
    respond_to do |format|
      if @final_position.present?
        format.json { render json: {location: @final_position} }
      else
        format.json { render json: @final_position.errors }
      end
    end
  end
end
