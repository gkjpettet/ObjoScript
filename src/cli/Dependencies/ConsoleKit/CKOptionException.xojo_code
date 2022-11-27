#tag Class
Protected Class CKOptionException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(code As Integer = 1, msg As String)
		  Me.ErrorNumber = code
		  Me.Message = msg
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Exception subclass for for all `CKCKOptionParser` exceptions.
		
		Raised in the following scenarios:
		
		1. Invalid use of the `CKOption` class, for example, you attempt to add
		   a new option but do not give a short or long option name.
		2. If the `CKCKOptionParser` has the `ExtrasRequired` parameter set and that
		   value has not been met by the user.
		3. A value is not valid for the given key. For example, if a `FileOption` requires that the file be 
		   readable and the parameter given is not readable, this exception will be raised. 
		4. An option is supplied on the command line that `CKCKOptionParser` has not been maded aware of.
		5. A required key has not been specified on the command line.
		
	#tag EndNote


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Message"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
