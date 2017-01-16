require 'rspec'
require 'page-object'
require 'require_all'
require 'logger'
require 'allure-cucumber'
require_relative 'check_ajax'

require_all File.dirname(__FILE__) + "/pages"
require_all File.dirname(__FILE__) + "/utilities"

load_all File.expand_path(File.dirname(__FILE__) + '/../../config/initializers')

include AllureCucumber::DSL

Dir.mkdir(File.dirname(__FILE__) + '/../../build') unless File.exists?(File.dirname(__FILE__) + '/../../build')

$LOG_FILE = File.expand_path(File.dirname(__FILE__) + '/../../build/log_file.log')
$LOG = Logger.new($LOG_FILE, 'daily')
$PROJECT_ROOT = File.expand_path(File.dirname(__FILE__) + '/../..')

World(PageObject::PageFactory)