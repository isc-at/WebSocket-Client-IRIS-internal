/// Enhanced WebSocket Echo Server from Caché SAMPLES
Class WSCI.EchoServer Extends %CSP.WebSocket
{

Method OnPreServer() As %Status
{
	Quit $$$OK
}

Method Server() As %Status
{
	Set $ZT="Error"
	Set timeout=10
	Set status=..Write("Welcome to Cache WebSocket. NameSpace: "_$NameSpace)
	For  {
		Set len=32656
		Set data=..Read(.len, .status, timeout)
		Set time = $ZDT($zts,3,,3)
		If $$$ISERR(status),$$$GETERRORCODE(status) = $$$CSPWebSocketClosed Quit
		If $$$ISERR(status),$$$GETERRORCODE(status) = $$$CSPWebSocketTimeout {
		   Set data=time_": Timeout after "_timeout_" seconds"
		   Set status=..Write(data)
		}
		else {
			If data="exit" Quit
			if $l(data,"to=")>1 set val=$p(data,"=",2),timeout=$s(val<5:5,1:val)
			Set data=time_": received '"_##class(%CSP.Page).EscapeHTML(data)_"'"_" (length="_len_")"
			Set status=..Write(data)
		}
	}
	Set status=..EndServer()
	Quit $$$OK
Error // Error
	Quit $$$OK
}

Method OnPostServer() As %Status
{
	Quit $$$OK
}

}
