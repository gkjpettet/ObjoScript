#tag Class
Protected Class ValueSet
	#tag Method, Flags = &h0, Description = 416464732060646020746F20746865207365742E2052657475726E732074686520696E64657820696E2074686520736574207468617420606460206F636375706965732E
		Function Add(d As Double) As Integer
		  /// Adds `d` to the set. Returns the index in the set that `d` occupies. 
		  
		  If mLookupTable.HasKey(d) Then
		    // Already in the set. Just return the index.
		    Return mLookupTable.Value(d)
		  Else
		    // Add this double.
		    mItems.Add(d)
		    mLookupTable.Value(d) = mitems.LastIndex
		    Return mItems.LastIndex
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732060736020746F20746865207365742E2052657475726E732074686520696E64657820696E2074686520736574207468617420607360206F636375706965732E
		Function Add(s As String) As Integer
		  /// Adds `s` to the set. Returns the index in the set that `s` occupies.  
		  
		  // Strings are stored in the lookup table hex encoded (for case-sensitivity).
		  Var encoded As String = EncodeHex(s)
		  
		  If mLookupTable.HasKey(encoded) Then
		    // Already in the set. Return the index.
		    Return mLookupTable.Value(encoded)
		  Else
		    // Add the string.
		    mItems.Add(s)
		    mLookupTable.Value(encoded) = mItems.LastIndex
		    Return mItems.LastIndex
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mLookupTable = New Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206054727565602069662060736020697320696E2074686973207365742E
		Function Contains(d As Double) As Boolean
		  /// Returns `True` if `d` is in this set.
		  
		  Return mLookupTable.HasKey(d)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206054727565602069662060736020697320696E2074686973207365742E
		Function Contains(s As String) As Boolean
		  /// Returns `True` if `s` is in this set.
		  
		  // Strings are stored internally in the lookup table hex encoded.
		  Var encoded As String = EncodeHex(s)
		  
		  Return mLookupTable.HasKey(encoded)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E64657820696E2074686520736574206F6620606460206F7220602D316020696620606460206973206E6F7420696E20746865207365742E
		Function IndexOf(d As Double) As Integer
		  /// Returns the index in the set of `d` or `-1` if `d` is not in the set.
		  
		  If mLookupTable.HasKey(d) Then
		    Return mLookupTable.Value(d)
		  Else
		    Return -1
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E64657820696E2074686520736574206F6620607360206F7220602D316020696620607360206973206E6F7420696E20746865207365742E
		Function IndexOf(s As String) As Integer
		  /// Returns the index in the set of `s` or `-1` if `s` is not in the set.
		  
		  // Strings are stored internally as hex encoded strings.
		  Var encoded As String = EncodeHex(s)
		  
		  If mLookupTable.HasKey(encoded) Then
		    Return mLookupTable.Value(encoded)
		  Else
		    Return -1
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520656C656D656E742061742060696E646578602E204D617920726169736520616E20604F75744F66426F756E6473457863657074696F6E602E
		Function Operator_Subscript(index As Integer) As Variant
		  /// Returns the element at `index`. May raise an `OutOfBoundsException`.
		  
		  Return mItems(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656275696C647320746865206C6F6F6B7570207461626C652062792074726176657273696E672074686520656E7469726520606D4974656D73602061727261792E2054686973206973207265717569726564207768656E6576657220616E20656C656D656E742069732072656D6F7665642E
		Private Sub RebuildLookupTable()
		  /// Rebuilds the lookup table by traversing the entire `mItems` array.
		  /// This is required whenever an element is removed.
		  
		  mLookupTable.RemoveAll
		  
		  Var iLimit As Integer = mItems.LastIndex
		  
		  Var item As Variant
		  For i As Integer = 0 To iLimit
		    item = mItems(i)
		    If item.Type = Variant.TypeString Then
		      // We store strings in the lookup table as hex encoded (to preserve case sensitivity).
		      mLookupTable.Value(EncodeHex(item)) = i
		    Else
		      mLookupTable.Value(item) = i
		    End If
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F766573206064602066726F6D20746865207365742E2052657475726E7320605472756560206966206064602077617320696E2074686520736574206F72206046616C73656020696620697420776173206E6F742E
		Function Remove(d As Double) As Boolean
		  /// Removes `d` from the set. Returns `True` if `d` was in the set or `False` if it was not.
		  ///
		  /// If `d` was removed, there is a performance penalty as we have to re-index the `mItems` array for the lookup table.
		  
		  If Not mLookupTable.HasKey(d) Then
		    Return False
		  Else
		    mItems.RemoveAt(mLookupTable.Value(d))
		    RebuildLookupTable
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F766573206073602066726F6D20746865207365742E2052657475726E7320605472756560206966206073602077617320696E2074686520736574206F72206046616C73656020696620697420776173206E6F742E
		Function Remove(s As String) As Boolean
		  /// Removes `s` from the set. Returns `True` if `s` was in the set or `False` if it was not.
		  ///
		  /// If `s` was removed, there is a performance penalty as we have to re-index the `mItems` array for the lookup table.
		  
		  // Strings are stored in the lookup table as hex encoded.
		  Var encoded As String = EncodeHex(s)
		  
		  If Not mLookupTable.HasKey(encoded) Then
		    Return False
		  Else
		    mItems.RemoveAt(mLookupTable.Value(encoded))
		    RebuildLookupTable
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320746865206974656D2061742060696E646578602E204D617920726169736520616E20604F75744F66426F756E6473457863657074696F6E602E
		Sub RemoveAt(index As Integer)
		  /// Removes the item at `index`. May raise an `OutOfBoundsException`.
		  
		  mItems.RemoveAt(index)
		  RebuildLookupTable
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Stores a mutable list of Objo values (strings and doubles).
		All values are guaranteed to be unique within the set.
		Stored strings are case-sensitive (stored as hex encoded strings).
		The index of a value within the set is stable until elements are removed.
		
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 546865206172726179206F6620756E69717565207072696D6974697665732E
		Private mItems() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4B6579203D20607072696D6974697665602C2056616C7565203D20496E64657820696E20606D4974656D7360206F6620607072696D6974697665602E
		Private mLookupTable As Dictionary
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
	#tag EndViewBehavior
End Class
#tag EndClass
