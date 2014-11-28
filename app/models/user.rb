class User < ActiveRecord::Base
  include User::Auth
end
