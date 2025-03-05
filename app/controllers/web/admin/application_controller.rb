module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      include AuthConcern
      include Pundit::Authorization
    end
  end
end
