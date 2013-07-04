# Dead-simple Guardfile reruns all the specs whenever anything changes
# Aside: it is *really* nice to work with POROs
guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { "spec" }
  watch('spec/spec_helper.rb')  { "spec" }
end

