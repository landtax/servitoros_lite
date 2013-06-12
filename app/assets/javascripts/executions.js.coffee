# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


update_executions = ->
  setTimeout ->
    $.get window.location.pathname + "/executions_list", (data) ->
      $('#executions_list').html(data)

    update_executions()
  ,60000

update_executions()





