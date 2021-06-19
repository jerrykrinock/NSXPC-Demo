# XPCDemo

Demo of a macOS app which contains a XPC service, ("Worker").  Demonstrates:

  * Basic – sending task to XPC service with result of work passed to a completion handler block.
  * How macOS automatically relaunches an XPC services if its process is killed.
  * "Reverse" messages initiated by the XPC service back to the app.
  
Note that XPC connections must always be created by a app *to* an XPC service.  An XPC service cannot initiate a connection with an app, nor can an app initiate a connection to another app.  (App-to-app communication is possible if both apps connect to the same XPC service which forwards messages from one connection to the other.)

Objective-C 2.0 with ARC.
