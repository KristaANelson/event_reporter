lib_dir = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib_dir)
data_dir = File.expand_path('data', __dir__)
$LOAD_PATH.unshift(data_dir)


require 'cli'

CLI.new($stdin, $stdout).call
