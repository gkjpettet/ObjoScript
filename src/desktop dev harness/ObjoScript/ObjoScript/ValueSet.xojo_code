#tag Class
Protected Class ValueSet
	#tag Method, Flags = &h0, Description = 41646473206120646F75626C652060646020746F20746865207365742E2052657475726E732074686520696E64657820696E2074686520736574207468617420606460206F636375706965732E
		Function Add(d As Double) As Integer
		  /// Adds a double `d` to the set. Returns the index in the set that `d` occupies.  
		  
		  // The lookup table stores values as hashes.
		  Var hash As UInteger = HashKit.Hash(d)
		  
		  // Is this double already present in the set?
		  Var index As Integer = mLookupTable.Lookup(hash, -1)
		  
		  If index = -1 Then
		    // This is a new value.
		    mItems.Add(d)
		    mLookupTable.Value(hash) = mItems.LastIndex
		    Return mItems.LastIndex
		  Else
		    // Already in the set.
		    Return index
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732060766020746F20746865207365742E2052657475726E732074686520696E64657820696E2074686520736574207468617420607660206F636375706965732E
		Function Add(v As ObjoScript.Value) As Integer
		  /// Adds `v` to the set. Returns the index in the set that `v` occupies.  
		  
		  // The lookup table stores values as hashes.
		  Var hash As UInteger = v.Hash
		  
		  // Is the value already in the set?
		  Var index As Integer = mLookupTable.Lookup(hash, -1)
		  
		  If index = -1 Then
		    // Add the value.
		    mItems.Add(v)
		    mLookupTable.Value(hash) = mItems.LastIndex
		    Return mItems.LastIndex
		  Else
		    // Already in the set.
		    Return index
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473206120737472696E672060736020746F20746865207365742E2052657475726E732074686520696E64657820696E2074686520736574207468617420607360206F636375706965732E20436173652073656E7369746976652E
		Function Add(s As String) As Integer
		  /// Adds a string `s` to the set. Returns the index in the set that `s` occupies.
		  /// Case sensitive.
		  
		  // The lookup table stores values as hashes.
		  Var hash As UInteger = HashKit.Hash(s)
		  
		  // Is this string already present in the set?
		  Var index As Integer = mLookupTable.Lookup(hash, -1)
		  
		  If index = -1 Then
		    // This is a new value.
		    mItems.Add(s)
		    mLookupTable.Value(hash) = mItems.LastIndex
		    Return mItems.LastIndex
		  Else
		    // Already in the set.
		    Return index
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // HACK: Creates a case-sensitive dictionary.
		  mLookupTable = ParseJSON("{}")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206054727565602069662060646020697320696E2074686973207365742E
		Function Contains(d As Double) As Boolean
		  /// Returns `True` if `d` is in this set.
		  
		  Return mLookupTable.HasKey(HashKit.Hash(d))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206054727565602069662060766020697320696E2074686973207365742E
		Function Contains(v As ObjoScript.Value) As Boolean
		  /// Returns `True` if `v` is in this set.
		  
		  Return mLookupTable.HasKey(v.Hash)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206054727565602069662060736020697320696E2074686973207365742E
		Function Contains(s As String) As Boolean
		  /// Returns `True` if `s` is in this set.
		  
		  Return mLookupTable.HasKey(HashKit.Hash(s))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E756D626572206F66206974656D7320696E20746865207365742E
		Function Count() As Integer
		  /// The number of items in the set.
		  
		  Return mItems.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E64657820696E2074686520736574206F6620646F75626C6520606460206F7220602D316020696620606460206973206E6F7420696E20746865207365742E
		Function IndexOf(d As Double) As Integer
		  /// Returns the index in the set of double `d` or `-1` if `d` is not in the set.
		  
		  Return mLookupTable.Lookup(HashKit.Hash(d), -1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E64657820696E2074686520736574206F6620607660206F7220602D316020696620607660206973206E6F7420696E20746865207365742E
		Function IndexOf(v As ObjoScript.Value) As Integer
		  /// Returns the index in the set of `v` or `-1` if `v` is not in the set.
		  
		  Return mLookupTable.Lookup(v.Hash, -1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520696E64657820696E2074686520736574206F6620737472696E6720607360206F7220602D316020696620607360206973206E6F7420696E20746865207365742E
		Function IndexOf(s As String) As Integer
		  /// Returns the index in the set of string `s` or `-1` if `s` is not in the set.
		  
		  Return mLookupTable.Lookup(HashKit.Hash(s), -1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206974656D2061742060696E646578602E204D617920726169736520616E20604F75744F66426F756E6473457863657074696F6E602E
		Function ItemAt(index As Integer) As Variant
		  /// Returns the item at `index`. May raise an `OutOfBoundsException`.
		  
		  Return mItems(index)
		  
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
		  For index As Integer = 0 To iLimit
		    item = mItems(index)
		    
		    // Compute the correct hash.
		    Var hash As UInteger
		    Select Case item.Type
		    Case Variant.TypeDouble, Variant.TypeInt64, Variant.TypeInt32
		      hash = HashKit.Hash(CType(item, Double))
		    Case Variant.TypeString
		      hash = HashKit.Hash(CType(item, String))
		    Else
		      If item IsA Value Then
		        hash = Value(item).Hash
		      Else
		        Raise New UnsupportedOperationException("Unsupported constant value type.")
		      End If
		    End Select
		    
		    mLookupTable.Value(hash) = index
		  Next index
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F766573206076602066726F6D20746865207365742E2052657475726E7320605472756560206966206076602077617320696E2074686520736574206F72206046616C73656020696620697420776173206E6F742E
		Function Remove(v As Variant) As Boolean
		  /// Removes `v` from the set. Returns `True` if `v` was in the set or `False` if it was not.
		  ///
		  /// If `v` was removed, there is a performance penalty as we have to re-index the `mItems` array for the lookup table.
		  
		  // Compute the hash.
		  Var hash As UInteger
		  Select Case v.Type
		  Case Variant.TypeDouble, Variant.TypeInt64, Variant.TypeInt32
		    hash = HashKit.Hash(CType(v, Double))
		  Case Variant.TypeString
		    hash = HashKit.Hash(CType(v, String))
		  Else
		    If v IsA Value Then
		      hash = Value(v).Hash
		    Else
		      Raise New UnsupportedOperationException("Unsupported constant value type.")
		    End If
		  End Select
		  
		  // Check the lookup table.
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


	#tag Note, Name = About
		A data structure for storing values used by the compiler and VM.
		
		It stores Doubles, Strings and Value interfaces as Variants in an array. Their hashes are stored in a 
		lookup table where the lookup table value is the hash and the value is the index in the Variant array of the 
		value being stored.
		
		We stored Doubles and Strings are native Xojo types rather than Value interfaces for performance reasons. Doing it
		this way means the VM doesn't have to unwrap them to manipulate them. All other items stored (e.g. Functions, etc) 
		are stored as classes implementing the Value interface.
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 546865206172726179206F662076616C7565732E
		Private mItems() As Variant
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
