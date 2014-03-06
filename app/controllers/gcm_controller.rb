class GcmController < ApplicationController
  # Key: AIzaSyCab6_dGG5XMlNIyGU-k18-dBZf2nGvz1U
  def push
	gcm = GCM.new('AIzaSyCdYuPNQ2sBEqaNkaQI2t3fStZV67nuZvQ')
	registration_ids = MobileDevice.all.map { |device| device.registration_id }
	options = { data: {
		data: params[:data]
	} }
	response = gcm.send_notification(registration_ids, options)
	render :json => {
		response: response
	}
  end

  def list
  	@devices = MobileDevice.all
  	# render :json => @devices
  end

  def delete
  	device = MobileDevice.find_by_registration_id(params[:registration_id])
  	device.delete
  	redirect_to gcm_list_path
  end

  def clear
  	MobileDevice.delete_all
  	redirect_to gcm_list_path
  end

  def reg
  	if !MobileDevice.find_by_registration_id(params[:registration_id])
	    mobile_device = MobileDevice.new({ 
		  :registration_id => params[:registration_id],
		  :email => params[:email]
		})
		mobile_device.save
		render :json => {
			status: 'success',
			device: mobile_device
		}
	else
		render :json => {
			status: 'fail',
			message: 'registration_id repeate'
		}
	end
  end
end
