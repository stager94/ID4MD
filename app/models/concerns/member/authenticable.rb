module Member
  module Authenticable
    
    extend ActiveSupport::Concern

    included do
      attr_accessor :login

      def login
        self.phone || self.email || self.id
      end

      def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
          where(conditions.to_h).where(["lower(phone) = :value OR lower(email) = :value OR id = :id", { value: login.downcase, id: login.downcase.to_i }]).first
        elsif conditions.has_key?(:username) || conditions.has_key?(:email)
          where(conditions.to_h).first
        end
      end

      def login=(login)
        @login = login
      end

    end
    
  end
end
