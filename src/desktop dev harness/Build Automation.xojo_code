#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyCoreLibraryLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vY29yZSUyMGxpYnJhcnkvY29yZS5vYmpv
				End
				Begin CopyFilesBuildStep CopyThemeLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vcmVzb3VyY2VzL0VkaXRvclRoZW1lLnRvbWw=
				End
				Begin CopyFilesBuildStep CopyTestsLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vdGVzdHMv
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				End
				Begin CopyFilesBuildStep CopyCoreLibraryMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vY29yZSUyMGxpYnJhcnkvY29yZS5vYmpv
				End
				Begin CopyFilesBuildStep CopyThemeMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vcmVzb3VyY2VzL0VkaXRvclRoZW1lLnRvbWw=
				End
				Begin CopyFilesBuildStep CopyTestsMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vdGVzdHMv
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyCoreLibraryWin
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vY29yZSUyMGxpYnJhcnkvY29yZS5vYmpv
				End
				Begin CopyFilesBuildStep CopyThemeWin
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vcmVzb3VyY2VzL0VkaXRvclRoZW1lLnRvbWw=
				End
				Begin CopyFilesBuildStep CopyTestsWin
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vdGVzdHMv
				End
			End
#tag EndBuildAutomation
