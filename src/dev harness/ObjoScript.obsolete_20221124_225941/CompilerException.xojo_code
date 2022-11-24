#tag Class
Protected Class CompilerException
Inherits RuntimeException
	#tag Method, Flags = &h0
		Sub Constructor(message As String, location As ObjoScript.Token)
		  Super.Constructor(message)
		  
		  Self.Location = location
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520746F6B656E20776865726520746865206572726F72206F726967696E617465642E
		Location As ObjoScript.Token
	#tag EndProperty


End Class
#tag EndClass
