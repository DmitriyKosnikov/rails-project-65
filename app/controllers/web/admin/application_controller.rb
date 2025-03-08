module Web
  module Admin
    class ApplicationController < ApplicationController
      include AuthConcern
      include Pundit::Authorization

      before_action :authenticate_user!
      before_action :authenticate_admin!
    end
  end
end
