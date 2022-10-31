module ControllerHelpers
    def sign_in(user)
      if user.nil?
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
      else
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(request.env['warden']).to receive(:authenticate).and_return(user)
        allow(User).to receive(:find_by).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        allow(controller).to receive(:logged_in?).and_return(true)
      end
    end
end