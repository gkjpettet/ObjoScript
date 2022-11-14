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
					FolderItem = Li4vLi4vLi4vc3RhbmRhcmQlMjBsaWJyYXJ5L2NvcmUub2Jqbw==
				End
				Begin CopyFilesBuildStep CopyTestsLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vdGVzdHMv
				End
				Begin CopyFilesBuildStep CopyFilesLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vcmVzb3VyY2VzL0VkaXRvclRoZW1lLnRvbWw=
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyCore
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vc3RhbmRhcmQlMjBsaWJyYXJ5L2NvcmUub2Jqbw==
				End
				Begin CopyFilesBuildStep CopyTestsMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vdGVzdHMv
				End
				Begin CopyFilesBuildStep CopyFilesMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vcmVzb3VyY2VzL0VkaXRvclRoZW1lLnRvbWw=
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
					FolderItem = Li4vLi4vLi4vc3RhbmRhcmQlMjBsaWJyYXJ5L2NvcmUub2Jqbw==
				End
				Begin CopyFilesBuildStep CopyTestsWindows
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vdGVzdHMv
				End
				Begin CopyFilesBuildStep CopyFilesWindows
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vLi4vcmVzb3VyY2VzL0VkaXRvclRoZW1lLnRvbWw=
				End
			End
#tag EndBuildAutomation
