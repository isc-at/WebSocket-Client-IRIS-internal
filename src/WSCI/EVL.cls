/// Event Listerner for WebSocket Client
/// local array %ct  counts OPEN, CLOSE, ERRORS, MeSSACGES
/// for debugging from terminal set %b=1 
Class WSCI.EVL Extends (%RegisteredObject, %Net.WebSocket.IEventListener)
{

/// Called when the web socket connection is successfully opened. <br />
/// @API.Overrideable
Method OnOpen()
{
	if $increment(%ct("O")) set io=$io use 0 write "OPEN",! break:$get(%b)  use io
}

/// Called when an error occurs in the web socket connection.<br />
/// @API.Overrideable
Method OnError(pError As %Exception.AbstractException)
{
	if $increment(%ct("E")) set io=$io use 0 write !
	do $system.OBJ.DisplayError()
	if pError.Code=28000 kill ws   use io quit     ;connection lost
	zwrite pError write ! break:$get(%b)  use io
}

/// Called when the web socket connection is closed by either the client (%OnClose) or the server (by sending a close frame).<br />
/// @API.Overrideable
Method OnClose()
{
 if $increment(%ct("C")) set io=$io use 0 write "CLOSE",! BREAK:$get(%b)   use io
}

/// Called when the client receives a message from the server. <br />
/// <var>pContent</var> may be a binary or UTF8-decoded character stream. <br />
/// @API.Overrideable
Method OnMessage(pContent As %Stream.Object)
{
	if $increment(%ct("M")) set io=$io use 0 write "MESSAGE:",pContent,! 
	if $isobject(pContent) write pContent.Read(),! 
	if $get(%b)  zwrite pContent BREAK  
	use io
}

}
