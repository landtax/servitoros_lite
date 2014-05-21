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

  $('#select_all').on 'change', (e) ->
    $('#upload_files tbody input[type="checkbox"]').prop("checked", $(@).prop("checked"))

  $('#language').on 'change', ->
    lang = @options[@selectedIndex].value
    location.href = "?locale=" + lang

  if ("#contando_modal").length > 0
    $('#contando_modal').modal({})

  $("#use_example_btn").on 'click', (e) ->
    lang = $('#execution_input_parameters_inputs_input_urls').data('lang')
    $('#execution_input_parameters_inputs_input_urls').val("http://contawords.iula.upf.edu/docs/" + lang + "/doc1.txt\nhttp://contawords.iula.upf.edu/docs/" + lang + "/doc2.txt")
    $('#execution_input_parameters_inputs_language').val(lang)
    return false

  $('#input_select_buttons button').on 'click', (e) ->
    type = $(e.target).attr("href").replace("#", "")
    $('#execution_type').val(type)

  $('#show_external_files').on 'click', (e) ->
    $('#basic_button').click()

  $($.cookie('tab')).click()








