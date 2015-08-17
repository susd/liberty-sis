ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'capybara/rails'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new, ENV, Minitest.backtrace_filter



module ActiveRecord
  class FixtureSet

    private

      def add_join_records(rows, row, association)
        # This is the case when the join table has no fixtures file
        if (targets = row.delete(association.name.to_s))
          table_name  = association.join_table
          column_type = association.primary_key_type
          lhs_key     = association.lhs_key
          rhs_key     = association.rhs_key
          join_class  = table_name.classify.constantize if Module.const_defined?(table_name.classify)

          targets = targets.is_a?(Array) ? targets : targets.split(/\s*,\s*/)

          rows[table_name].concat targets.map { |target|
            join_row = {
              lhs_key => row[primary_key_name],
              rhs_key => ActiveRecord::FixtureSet.identify(target, column_type)
            }
            if join_class && join_class.record_timestamps
              now = config.default_timezone == :utc ? Time.now.utc : Time.now
              now = now.to_s(:db)
              timestamp_column_names.each do |c_name|
                join_row[c_name] = now unless join_row.key?(c_name)
              end
            end
            join_row
          }
        end
      end

  end
end


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionView::TestCase
  include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  include Warden::Test::Helpers

  private

  def with_user(user, scope = :user)
    login_as(user, scope: scope)
    yield if block_given?
    logout(user)
  end
end
