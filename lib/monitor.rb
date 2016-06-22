ENV['RAILS_ENV'] ||= 'development'

root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, 'config', 'environment')

EventMachine.run do
  Instance.all.map do |i|
    http = EventMachine::HttpRequest.new(i.url << ':9292').get(query: { token: i.token })
    json_string = ''
    http.stream do |data|
      begin
        p data
        json_string << data
        attrs = JSON.parse(json_string)
        json_string = ''
        attrs['processes_attributes'] = attrs.delete('processes')
        datapoint = i.datapoints.create(attrs)
        ActionCable.server.broadcast "monitor_#{i.id}", datapoint.to_json
      rescue StandardError => e
        p e unless e.is_a?(JSON::ParserError)
      end
    end
  end
end
