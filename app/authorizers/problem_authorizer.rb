class ProblemAuthorizer < ApplicationAuthorizer
  class << self
    def default(adjective, user)
      ! user.guest?
    end
  end
end
