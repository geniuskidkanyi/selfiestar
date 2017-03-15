Rails.application.config.middleware.use Browsernizer::Router do |config|
  config.supported "Edge", "13"
  config.supported "Firefox", "51"
  config.supported "Opera", "43"
  config.supported "Chrome", "4"
  config.supported "Android", "4.0"
  config.supported "BlackBerry", "51"
  config.supported "Safari", "8"
  config.supported "Internet Explorer", "11"
  config.supported "Samsung Internet", "3"
  config.supported "Android Browser", "4.0"
  config.supported "iOS Safari", "8.0"
  config.supported "UCBrowser",  false
  config.location  "/browser.html"
  config.exclude   %r{^/assets}
end
