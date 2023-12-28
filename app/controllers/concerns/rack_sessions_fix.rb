# frozen_string_literal: true

# Module to fix ActionDispatch::Request::Session::DisabledSessionError
module RackSessionsFix
  extend ActiveSupport::Concern

  # Create fake rack sessions
  class FakeRackSession < Hash
    def enabled?
      false
    end

    def destroy; end
  end

  included do
    before_action :set_fake_session

    private

    def set_fake_session
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
