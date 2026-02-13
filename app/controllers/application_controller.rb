class ApplicationController < ActionController::API
  # this is needed if not rails will automatically wrap the body to outside hash
  wrap_parameters false
end
