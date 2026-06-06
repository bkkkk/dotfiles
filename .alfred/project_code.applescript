on alfred_script(q)
	set docsDirectory to "Macintosh HD:Users:jacoboblanco:Library:Mobile Documents:com~apple~CloudDocs:Documents:"
	set icloudDirectoryPosix to "/Users/jacoboblanco/Library/Mobile Documents/com~apple~CloudDocs/"
	set docsDirectoryPosix to icloudDirectoryPosix & "Documents/"
	set notesDirectory to docsDirectory & "notes:"
	set projectsFileName to "project-codes.md"
	set projectsFilePath to (docsDirectoryPosix & "notes/" & projectsFileName)
	set craftsSpaceId to "4c377cad-42c6-f36a-6632-8d7a0d9fe119"
	
	tell application "Finder"
		if exists (projectsFilePath) as POSIX file then
		else
			do shell script "echo '' > " & quoted form of (projectsFilePath)
		end if
	end tell
	
	set projectsList to first item of (read projectsFilePath using delimiter linefeed)
	if projectsList is not equal to "" then
		set oldDelimiters to AppleScript's text item delimiters
		set AppleScript's text item delimiters to " | "
		set dateCode to first text item of projectsList
		set AppleScript's text item delimiters to "-"
		set existingYear to text 3 thru 6 of (first text item of dateCode)
		set existingCode to last text item of dateCode
		set AppleScript's text item delimiters to oldDelimiters
	else
		set existingYear to "1900"
	end if
	set currentYear to year of (current date) as string
	if existingYear = currentYear then
		set newNumber to "0000" & ((existingCode as number) + 1) as string
		set numberString to text ((length of newNumber) - 3) thru (length of newNumber) of newNumber
	else
		set numberString to "0001"
	end if
	
	set newCode to currentYear & "-" & numberString
	set projectName to q
	
	set projectText to newCode & " | " & projectName
	set projectDirectory to (icloudDirectoryPosix) & "projects/" & projectText
	
	do shell script "mkdir " & quoted form of projectDirectory
	
	tell application "OmniFocus"
		tell document of front window
			set theProject to make new project with properties {name:projectText}
			set projectID to the id of theProject
			set projectURL to "[OmniFocus Project](omnifocus://task/" & projectID & ")"
			set encoded to do shell script "perl -MURI::Escape -lne 'print uri_escape($_)' <<<" & quoted form of q
			set newProjectDirectory to ((docsDirectoryPosix as string) & "projects/" & projectText & "/")
			set textEncoded to do shell script "perl -MURI::Escape -lne 'print uri_escape($_)' <<<" & quoted form of projectText
		end tell
	end tell
	
	do shell script "echo " & (quoted form of ("[[" & projectText & "]]")) & " >> " & (quoted form of projectsFilePath)
	do shell script "sort -r " & (quoted form of projectsFilePath) & " -o " & (quoted form of projectsFilePath)
	
	set craftCreateUri to "craftdocs://createdocument?spaceId=" & craftsSpaceId & "title=" & projectText & "&content=" & projectURL & "&folderId="	open location craftCreateUri
	
	return projectURL
	
end alfred_script
