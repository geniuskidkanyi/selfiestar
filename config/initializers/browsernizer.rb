Rails.application.config.middleware.use Browsernizer::Router do |config|
  config.supported "Edge", "13"
  config.supported "Firefox", "51"
  config.supported "Opera", false
  config.supported "Chrome", "4"
  config.supported "Android", "4.4"
  config.supported "BlackBerry", false
    config.supported "nokia S40 Ovi Browser", false
  config.supported "Safari", "8"
  config.supported "Internet Explorer", "13"
  config.supported "Samsung Internet", "4"
  config.supported "Android Browser", "4.4"
  config.supported "iOS Safari", "8.0"
  config.supported "UCBrowser",  false
  config.supported "QQ Browser",  false
  config.supported "Generic Browser",  false
  config.location  "/browser.html"
  config.exclude   %r{^/assets}
end
