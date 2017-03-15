Rails.application.config.middleware.use Browsernizer::Router do |config|
  config.supported "Edge", "13"
  config.supported "Firefox", "51"
  config.supported "Opera", "43"
  config.supported "Chrome", "49"
  config.supported "Android", "4.0"
  config.supported "BlackBerry", "51"
  config.supported "Safari", "10"
  config.supported "Internet Explorer", "11"
  config.location  "/browser.html"
  config.exclude   %r{^/assets}
end
