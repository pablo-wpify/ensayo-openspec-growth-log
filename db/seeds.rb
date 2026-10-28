# Seeds create data only in development. The data-creating part lives in
# db/seeds/development.rb so that tests can check it is never reached in
# other environments. Load with bin/rails db:seed.
require_relative "seeds/development"

DevelopmentSeeds.run if Rails.env.development?
