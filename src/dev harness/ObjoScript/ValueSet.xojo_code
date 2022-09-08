#tag Class
Protected Class ValueSet
	#tag Method, Flags = &h0, Description = 416464732060736020746F20746865207365742E2052657475726E732074686520696E64657820696E2074686520736574207468617420607360206F636375706965732E
		Function Add(v As ObjoScript.Value) As Integer
		  /// Adds `v` to the set. Returns the index in the set that `v` occupies.  
		  
		  Var hash As Integer = v.Hash
		  
		  If mLookupTable.HasKey(hash) Then
		    // Already in the set. Return the index.
		    Return mLookupTable.Value(hash)
		  Else
		    // Add the value.
		    mItems.Add(v)
		    mLookupTable.Value(hash) = mItems.LastIndex
		    Return mItems.LastIndex
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mLookupTable = New Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206054727565602069662060766020697320696E2074686973207365742E
		Function Contains(v As ObjoScript.Value) As Boolean
		  /// Returns `True` if `v` is in this set.
		  
		  Return mLookupTable.HasKey(v.Hash)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E64657820696E2074686520736574206F6620607660206F7220602D316020696620607660206973206E6F7420696E20746865207365742E
		Function IndexOf(v As ObjoScript.Value) As Integer
		  /// Returns the index in the set of `v` or `-1` if `v` is not in the set.
		  
		  Return mLookupTable.Lookup(v.Hash, -1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520656C656D656E742061742060696E646578602E204D617920726169736520616E20604F75744F66426F756E6473457863657074696F6E602E
		Function Operator_Subscript(index As Integer) As ObjoScript.Value
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
		    mLookupTable.Value(item.Hash) = i
		  Next i
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F766573206076602066726F6D20746865207365742E2052657475726E7320605472756560206966206076602077617320696E2074686520736574206F72206046616C73656020696620697420776173206E6F742E
		Function Remove(v As ObjoScript.Value) As Boolean
		  /// Removes `v` from the set. Returns `True` if `v` was in the set or `False` if it was not.
		  ///
		  /// If `v` was removed, there is a performance penalty as we have to re-index the `mItems` array for the lookup table.
		  
		  Var hash As Integer = v.Hash
		  
		  If Not mLookupTable.HasKey(hash) Then
		    Return False
		  Else
		    mItems.RemoveAt(mLookupTable.Value(hash))
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


	#tag Property, Flags = &h21, Description = 546865206172726179206F662076616C7565732E
		Private mItems() As ObjoScript.Value
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4B6579203D206076616C75652068617368602C2056616C7565203D20496E64657820696E20606D4974656D7360206F66206076616C7565602E
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
