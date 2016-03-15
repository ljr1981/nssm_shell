note
	description: "[
		Representation of an {NSSM_ACCESSOR_32}
		]"

class
	NSSM_ACCESSOR_32

inherit
	LE_LOGGING_AWARE

feature {TEST_SET_BRIDGE} -- Implementation: Status Report

	nssm_directory: DIRECTORY
			-- `nssm_directory' as `nssm_relative_path'.
		do
			create Result.make_with_path (nssm_relative_path)
		end

	nssm_directory_exists: BOOLEAN
			-- `nssm_directory_exists' at `nssm_relative_path'
		do
			Result := nssm_directory.exists
		end

	has_nssm_exe: BOOLEAN
			-- `has_nssm_exe' in `nssm_directory'
		do
			Result := nssm_directory.exists and then nssm_directory.has_entry (nssm_exe_string)
		end

feature {TEST_SET_BRIDGE} -- Implementation: Constants

	nssm_relative_path: PATH
			-- `nssm_relative_path' to either 32 or 64 bit EXE.
		note
			warning: "[
				Any finalized EXE must have this path available
				in order to have the appropriate NSSM.EXE reachable.
				]"
		once
			create Result.make_from_string (nssm_path_string)
			logger.write_information (Result.absolute_path.name.out)
		end

	nssm_path_string: STRING
			-- `nssm_relative_path_string' for Current.
		once
			Result := "nssm-" + nssm_version_string + "\" + nssm_win32_folder_name_string
		end

	nssm_version_string: STRING = "2.24"
			-- `nssm_version_string' for Current.

	nssm_exe_string: STRING = "nssm.exe"
			-- `nssm_exe_string' for Current.

	nssm_win32_folder_name_string: STRING = "win32"
	nssm_win64_folder_name_string: STRING = "win64"

invariant
	has_nssm_exe: has_nssm_exe -- Fails due to missing nssm.exe in appropriate subfolder.

note
	design: "[
		This class wraps one of two versions of NSSM (32/64-bit) EXEs.
		]"
	EIS: "name=nssm_home", "src=https://nssm.cc/"
	EIS: "name=nssm_command_line", "src=https://nssm.cc/commands"
end
