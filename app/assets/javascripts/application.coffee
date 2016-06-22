#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require lazybox
#= require cable
#= require_tree .

$.rails.allowAction = $.lazybox.confirm
$.lazybox.settings = {cancelClass: 'button button-primary', submitClass: 'button button-secondary'}

@App = {}
@App.cable = Cable.createConsumer('/cable')

$(document).on 'turbolinks:load', ->
  if $('[data-instance]')[0]
    App.monitor = App.cable.subscriptions.create { channel: 'MonitorChannel', instance_id: $('[data-instance]').data('instance') },
      received: (data) ->
        info = JSON.parse(data)
        $('table caption').text("CPU: #{info.cpu} Disk: Available: #{info.disk.available}, Used: #{info.disk.used}")
        $('table tbody').html($.map(info.processes, (process) ->
            "<tr class='align-center'><td>#{process.pid}</td><td>#{process.user}</td><td>#{process.cpu}</td><td>#{process.mem}</td><td>#{process.name}</td><tr/>"
        ))
  else
    App.monitor.unsubscribe() if App.monitor
    App.monitor = null

MONITOR_HTML = "<table class='table'><thead></thead></table>"
