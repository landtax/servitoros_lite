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

  $('#language').on 'change', ->
    lang = @options[@selectedIndex].value
    location.href = "?locale=" + lang

  if ("#contando_modal").length > 0
    $('#contando_modal').modal({})

  $("#use_example_btn").on 'click', (e) ->
    $('#execution_input_parameters_inputs_input_urls').val("http://gilmere.upf.edu/WS/upload/system/files/125/original/UTF-8.txt\nhttp://gilmere.upf.edu/WS/upload/system/files/115/original/large2.txt")
    $('#execution_input_parameters_inputs_language').val('es')
    return false

  $('#input_select_buttons button').on 'click', (e) ->
    type = $(e.target).attr("href").replace("#", "")
    $('#execution_type').val(type)

  $('#show_external_files').on 'click', (e) ->
    $('#basic_button').click()

  $($.cookie('tab')).click()







