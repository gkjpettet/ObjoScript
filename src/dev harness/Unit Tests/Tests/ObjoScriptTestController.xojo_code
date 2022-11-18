#tag Class
Protected Class ObjoScriptTestController
Inherits TestController
	#tag Event
		Sub InitializeTestGroups()
		  // Instantiate TestGroup subclasses here so that they can be run.
		  
		  Var group As TestGroup
		  
		  // Language.
		  group = New LanguageAssignmentTests(Self, "Language - Assignment")
		  group = New LanguageExitTests(Self, "Language - Exit")
		  group = New LanguageClassTests(Self, "Language - Class")
		  group = New LanguageCommentTests(Self, "Language - Comments")
		  group = New LanguageConditionalTests(Self, "Language - Conditional")
		  group = New LanguageConstructorTests(Self, "Language - Constructor")
		  group = New LanguageFieldTests(Self, "Language - Field")
		  group = New LanguageForTests(Self, "Language - For")
		  group = New LanguageForEachTests(Self, "Language - ForEach")
		  group = New LanguageForeignTests(Self, "Language - Foreign")
		  group = New LanguageFunctionTests(Self, "Language - Function")
		  group = New LanguageIfTests(Self, "Language - If")
		  group = New LanguageImplicitReceiverTests(Self, "Language - Implicit Receiver")
		  group = New LanguageInheritanceTests(Self, "Language - Inheritance")
		  group = New LanguageListTests(Self, "Language - List")
		  group = New LanguageLogicalOperatorTests(Self, "Language - Logical Operator")
		  group = New LanguageMethodTests(Self, "Language - Methods")
		  group = New LanguageNonLocalTests(Self, "Language - Non Local")
		  group = New LanguageNothingTests(Self, "Language - Nothing")
		  group = New LanguageNumberTests(Self, "Language - Numbers")
		  group = New LanguageReturnTests(Self, "Language - Return")
		  group = New LanguageSetterTests(Self, "Language - Setter")
		  group = New LanguageStaticFieldTests(Self, "Language - Static Field")
		  group = New LanguageStringTests(Self, "Language - String")
		  group = New LanguageSuperTests(Self, "Language - Super")
		  group = New LanguageThisTests(Self, "Language - This")
		  group = New LanguageVariableTests(Self, "Language - Variable")
		  group = New LanguageWhileTests(Self, "Language - While")
		  group = New LanguageMiscTests(Self, "Language - Misc")
		  group = New LanguageMapTests(Self, "Language - Map")
		  
		  // Core.
		  group = New CoreMapTests(Self, "Core - Map")
		  group = New CoreStringTests(Self, "Core - String")
		End Sub
	#tag EndEvent


	#tag ViewBehavior
		#tag ViewProperty
			Name="AllTestCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Duration"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailedCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GroupCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsRunning"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NotImplementedCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PassedCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RunGroupCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RunTestCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SkippedCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
