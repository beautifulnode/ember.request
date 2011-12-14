fs = require 'fs'
{print} = require 'util'
{ spawn } = require 'child_process'

# ANSI Terminal Colors
bold = '\033[0;1m'
green = '\033[0;32m'
reset = '\033[0m'
red = '\033[0;31m'

log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')


build = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false
    
  options = ['-c', '-o', 'js', 'src']
  options.unshift '-w' if watch

  coffee = spawn 'coffee', options
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> log data.toString(), red
  coffee.on 'exit', (status) -> callback?() if status is 0

spec = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false
    
  options = ['-c', 'test']
  options.unshift '-w' if watch

  coffee = spawn 'coffee', options
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> log data.toString(), red
  coffee.on 'exit', (status) -> callback?() if status is 0

buster = (cb) ->
  buster = spawn 'buster', ['test']
  buster.stdout.on 'data', (data) -> print data.toString()
  buster.stderr.on 'data', (data) -> log data.toString(), red
  buster.on 'exit', (status) -> callback?() if status is 0
  

task 'setup-test', 'run buster server', ->
  bs = spawn 'buster', ['server']
  
  bs.stdout.on 'data',(data) ->
    console.log('stdout: ' + data)
    browser = spawn 'open', ['http://localhost:1111']
    console.log 'Connect to Clients'

  bs.on 'exit', (code) ->
    console.log('child process exited with code ' + code)
    
task 'test', 'run buster tests', ->
  build -> spec -> buster -> log ':-)', green
  
task 'compile', "Compile Ember.Request", ->
  build -> log ':-)', green