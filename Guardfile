guard :rspec, cmd: 'spring rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
end

guard :rubocop do
  watch(%r{.+\.rb$})
end

guard :coffeelint, config_file: 'coffeelint.json' do
  watch(%r{^frontend/(.+)\.coffee$})
  watch(%r{^renderer/(.+)\.coffee$})
end
