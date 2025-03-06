module Web
  module Admin
    class ApplicationController < ApplicationController
      include AuthConcern
      include Pundit::Authorization
    end
  end
end
