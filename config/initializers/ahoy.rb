class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore
  Ahoy.visit_duration = 30.minutes
  Ahoy.track_visits_immediately = true
end
