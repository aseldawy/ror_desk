ActionController::Routing::Routes.draw do |map|
  map.odesk '/odesk', :controller=>'odesk', :action=>'index', :method=>:get
end

