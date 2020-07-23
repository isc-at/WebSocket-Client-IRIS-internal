 ~~~
 This is a coding example working on IRIS 2020.1 and on Caché 2018.1.3 
 It will not be kept in sync with new versions      
 It is also NOT serviced by InterSystems Support !   
~~~ 

IRIS 2010.1 brought us a new feature: %Net.WebSocket.Client  

As a continuation of my series of WS Clients I just couldn't resist to try it.  
Well, this is the result and it was rather simple in the end.    
   - After I succeeded in my personal fight against Windows Firewall ;-)   
   
You basically need to prepare 3 classes:  
- Credentials for User,  PW, SSL   
- an Event Listener
- the Client  (Could be a .MAC routine as well) 

The example uses the WSS.EchoServer (a derivate from former SAMPLES in Caché).  
The default assumption is to have Client and Server on the same system & namespace.  
But if you have some other echo server (e.g. ws://echo.websocket.org)    
you just pass the URL as param.  

You start it  
by DO ##CLASS(WSCI.Client).Try()  
or DO ##CLASS(WSCI.Client).Try(server_url)  

USER>DO ##CLASS(WSCI.Client).Try()   
OPEN  
MESSAGE:10@%Stream.TmpCharacter   
Welcome to Cache WebSocket. NameSpace: USER   
--------------- next ---------------  
new message (*=exit):MESSAGE:8@%Stream.TmpCharacter  
2020-04-04 18:33:53.319: received 'hallo WS demo server' (length=20)  
--------------- next ---------------  
new message (*=exit):MESSAGE:10@%Stream.TmpCharacter  
2020-04-04 18:34:03.320: Timeout after 10 seconds  
--------------- next ---------------  
new message (*=exit):this is my demo  
--------------- next ---------------  
new message (*=exit):MESSAGE:5@%Stream.TmpCharacter  
2020-04-04 18:34:09.851: received 'this is my demo' (length=15)  
--------------- next ---------------  
--------------- next ---------------  
new message (*=exit):MESSAGE:10@%Stream.TmpCharacter  
2020-04-04 18:34:19.866: Timeout after 10 seconds  
--------------- next ---------------  
new message (*=exit):longer timeout  
MESSAGE:8@%Stream.TmpCharacter  
2020-04-04 18:34:29.132: received 'lange' (length=5)  
--------------- next ---------------  
new message (*=exit):MESSAGE:11@%Stream.TmpCharacter  
2020-04-04 18:34:39.132: Timeout after 10 seconds  
--------------- next ---------------  
new message (*=exit):MESSAGE:8@%Stream.TmpCharacter  
2020-04-04 18:34:41.132: received 'longer timeout' (length=14)  
--------------- next ---------------  
new message (*=exit):MESSAGE:11@%Stream.TmpCharacter  
2020-04-04 18:34:51.148: Timeout after 10 seconds  
--------------- next ---------------  
new message (*=exit):to=17  
--------------- next ---------------  
new message (*=exit):MESSAGE:5@%Stream.TmpCharacter  
2020-04-04 18:34:55.866: received 'to=17' (length=5)  
--------------- next ---------------  
--------------- next ---------------  
new message (*=exit):MESSAGE:11@%Stream.TmpCharacter  
2020-04-04 18:35:12.882: Timeout after 17 seconds  
--------------- next ---------------  
--------------- next ---------------  
new message (*=exit):*  
--------------- next ---------------  
    
ERROR #28000: Connection closed  
USER>  
   
