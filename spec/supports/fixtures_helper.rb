# frozen_string_literal: true

require 'json'

module FixturesHelper
  def load_fixture(file_path)
    JSON.parse(File.read(File.join(File.dirname(__FILE__), '../fixtures', file_path)))
  end
end