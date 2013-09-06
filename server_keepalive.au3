#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=server_keepalive.exe
#AutoIt3Wrapper_Outfile_x64=server_keepalive.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
$x=0
$status = 0
Do
	TCPStartup()
	$status = TCPConnect("127.0.0.1","4567")
	TCPCloseSocket("4567")
	if $status <= 0 Then
		Run("C:\ruby200-x64\bin\ruby.exe C:\users\browserstack\documents\gitrepos\browser_server\listener.rb", "", @SW_HIDE)
	EndIf
 Sleep(1000)
Until $x = 1