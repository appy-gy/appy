deps = %w{sys/proctable dotenv colorize}
begin
  deps.each { |dep| require dep }
rescue LoadError
  puts 'Some deps are missing. Run "bundle install" and restart script'
  exit
end

COLORS = {
  notice: :white,
  success: :green,
  warning: :yellow,
  error: :red
}

$orig_stdout = $stdout.dup
$stdout.reopen '/dev/null', 'w'

def write *args
  $stdout.reopen $orig_stdout
  if args.first.is_a? Symbol
    type = args.shift
    color = COLORS[type]
    args.map! { |arg| arg.to_s.public_send(color) }
  end
  puts *args
  $stdout.reopen '/dev/null', 'w'
end

Tracker = Class.new do
  def initialize
    @tasks = []
  end

  def run
    write "#{@tasks.count} tasks to do"
    @tasks.each_with_index do |task, index|
      begin
        write "Run #{index.succ}/#{@tasks.count} task - #{task.name}"
        task.run
      rescue => error
        write :error, "Task '#{task.name}' failed"
        write :error, error.message
        write :error, error.backtrace
        exit
      end
    end
    write :success, 'Finished'
  end

  def add task
    @tasks.push task
  end
end.new

class Task
  attr_reader :name

  def initialize name, &block
    @name = name
    define_singleton_method :run, &block
    Tracker.add self
  end
end

Task.new 'Check git presence' do
  return write :success, 'Looks like .git dir is here' if Dir.exists? '.git'
  write :error, '.git directory is missing. You probably run this script within wrong directory'
  exit
end

Task.new 'Check postgres' do
  unless system 'which psql'
    write :error, 'Postgres isn\'t installed. You should install it yourself'
    exit
  end
  write :success, 'Postgres is installed'
  return write :success, 'Postgres is running' if Sys::ProcTable.ps.any? { |process| process.cmdline.include? 'postgres' }
  write :error, 'Postgres isn\'t running. You should start it yourself'
  exit
end

Task.new 'Git pull' do
  system 'git pull'
  write :success, 'Updated git repo'
end

Task.new 'Update gems' do
  system 'bundle install'
  write :success, 'Gems updated'
end

Task.new 'Migrate database' do
  system 'spring rake db:migrate'
  write :success, 'Migrated database'
end

Task.new 'Update node modules' do
  unless File.exists? 'package.json'
    return write :warning, 'There is no package.json in root folder of project. Skipping this step'
  end
  system 'npm install'
  write 'Updated node modules'
end

Task.new 'Check .env' do
  env = Dotenv.load '.env'
  sample = Dotenv.load '.env.sample'
  missing = sample.keys - env.keys
  return write :success, 'There is no missing keys in your .env' if missing.empty?
  write :warning, "There is some missing keys in your .env. Here they are: #{missing.join ', '}"
end

Task.new 'Checkout some files' do
  system 'git checkout db/schema.rb'
end

Tracker.run
