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

$(document).ready ->
  $('#input_select_buttons button').on 'click', (e) ->
    type = $(e.target).attr("href").replace("#", "")
    $('#execution_type').val(type)
  $('#show_external_files').on 'click', (e) ->
    $('#basic_button').click()




