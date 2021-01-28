
module Tokenable
    extend ActiveSupport::Concern
  
    included do
      before_create :generate_token
    end
  
    protected
  
    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
end
