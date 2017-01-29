module Devise
  module Models
    module Lockable

      def lock_access!(opts = { })
        p self.reason = "failed attempt"
        p self.locked_at = Time.now
        p self.deactivated_date = self.locked_at
        p self.locked = "locked"
        self.save
      end

      def unlock_access!
        self.locked_at = nil
        self.reason = ""
        self.locked_at = ""
        self.deactivated_date = ""
        self.locked = "active"
        self.failed_attempts = 0 if respond_to?(:failed_attempts=)
        self.unlock_token = nil  if respond_to?(:unlock_token=)
        save(validate: false)
      end
    end
  end
end
