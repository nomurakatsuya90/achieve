require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
# この一行を追記
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
#課題の追加ページその1　20210129 k.nomura
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'test01.html.erb')
#課題の追加CGIその1　20210129 k.nomura
server.mount('/goya_nojika.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_nojika.rb')
#課題の追加CGIその2　20210129 k.nomura
server.mount('/goya_qltyf.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_qltyf.rb')

server.start
