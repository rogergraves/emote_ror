#Patch to utilize resource.banned field nicely
module Devise
  module Models
    module DatabaseAuthenticatable
      def active?
        if self.respond_to?(:banned)
          !banned
        else
          true
        end
      end

      def inactive_message
        if self.respond_to?(:banned)
          banned ? :banned : :inactive
        else
          :inactive
        end
      end
    end
  end
end