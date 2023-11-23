#tag Class
Protected Class Func
Implements ObjoScript.Value,ObjoScript.Method
	#tag Method, Flags = &h0
		Sub Constructor(name As String, parameterTokens() As ObjoScript.Token, isSetter As Boolean, debugMode As Boolean)
		  Self.Name = name
		  
		  For Each paramToken As ObjoScript.Token In parameterTokens
		    Self.Parameters.Add(paramToken.Lexeme)
		  Next paramToken
		  
		  Arity = parameters.Count
		  
		  Self.Chunk = New ObjoScript.Chunk(debugMode)
		  
		  Self.IsSetter = isSetter
		  
		  mSignature = ComputeSignature(name, arity, isSetter)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As Integer
		  /// Returns a (hopefully) unique hash value for this function.
		  ///
		  /// We hash and combine a few of this function's properties in a balance between 
		  /// true uniqueness and the time is takes to hash.
		  /// Part of the ObjoScript.Value interface.
		  
		  Var hash As Integer = HashKit.Hash(mSignature)
		  
		  For Each param As String In Self.Parameters
		    HashKit.Combine(hash, param)
		  Next param
		  
		  HashKit.Combine(hash, Chunk.Length)
		  
		  HashKit.Combine(hash, Chunk.Constants.Count)
		  
		  // We'll also hash the line numbers and script IDs for a small number of the 
		  // bytes in the chunk as without this it is possible to get hash collisions 
		  // with very similar but distinct functions.
		  If Chunk.Length > 0 Then
		    Var i As Integer = 0
		    Const HASH_ITERATIONS = 3
		    While i < Chunk.Length And i <= HASH_ITERATIONS
		      HashKit.Combine(hash, CType(Chunk.LineForOffset(i), Integer))
		      HashKit.Combine(hash, Chunk.ScriptIDForOffset(i))
		      i = i + 1
		    Wend
		  End If
		  
		  // If this function has any code, we'll also hash two random bytes and the script ID for the chunk.
		  If Chunk.Length > 0 Then
		    Var offset As Integer = System.Random.InRange(0, Chunk.Length - 1)
		    Var randomByte As Integer = Chunk.Code(offset)
		    HashKit.Combine(hash, randomByte)
		    
		    offset = System.Random.InRange(0, Chunk.Length - 1)
		    randomByte = Chunk.Code(offset)
		    HashKit.Combine(hash, randomByte)
		    
		    HashKit.Combine(hash, Chunk.ScriptIDForOffset(offset))
		  End If
		  
		  Return hash
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732066756E6374696F6E2773207369676E61747572652E
		Function Signature() As String
		  /// This function's signature.
		  
		  Return mSignature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  /// Returns a string representation of this function.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return mSignature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As ObjoScript.ValueTypes
		  /// This value's type.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.Func
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620617267756D656E747320746869732066756E6374696F6E2072657175697265732E
		Arity As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732066756E6374696F6E2773206368756E6B206F662062797465636F64652E
		Chunk As ObjoScript.Chunk
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686973206973206120736574746572206D6574686F642E
		IsSetter As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546869732066756E6374696F6E2773207369676E61747572652E
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732066756E6374696F6E2773206E616D652E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D6573206F6620746869732066756E6374696F6E277320706172616D65746572732028696E206F72646572292E204D617920626520656D7074792E
		Parameters() As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsSetter"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Arity"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
