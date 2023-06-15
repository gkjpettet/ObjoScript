#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyCoreLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vUmVwb3MvT2Jqb1NjcmlwdC9jb3JlJTIwbGlicmFyeS9jb3JlLm9iam8=
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyCoreMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vY29yZSUyMGxpYnJhcnkvY29yZS5vYmpv
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyCoreWin
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vUmVwb3MvT2Jqb1NjcmlwdC9jb3JlJTIwbGlicmFyeS9jb3JlLm9iam8=
				End
			End
#tag EndBuildAutomation
