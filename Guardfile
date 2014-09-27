# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :minitest do

  watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/dummy/app/(.+)\.rb$})                    { |m| "test/dummy/test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { 'test' }
  watch(%r{^test/support/.+_helper\.rb$}) { 'test' }
  
  watch(%r{^test/dummy/test/factories/(.+)\.rb$}) { 'test/meta/factories_test.rb' }


end
