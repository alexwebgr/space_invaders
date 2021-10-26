RSpec.shared_context("file_helper") do
  def file_fixture(fixture_name)
    Pathname.new(File.join('spec/fixtures', fixture_name))
  end
end
