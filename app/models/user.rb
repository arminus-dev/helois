class User < ActiveRecord::Base
  has_many :todos, :dependent=> :destroy
  acts_as_authentic do |c|
    c.login_field = 'email'
  end

end
