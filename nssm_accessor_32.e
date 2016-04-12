note
	description: "[
		Representation of an {NSSM_ACCESSOR_32}
		]"

class
	NSSM_ACCESSOR_32

inherit
	FW_PROCESS_HELPER

feature {TEST_SET_BRIDGE} -- Implementation: Service Installation

	nssm_install (a_service_name: STRING)
			-- `nssm_install' `a_service_name'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe install " + a_service_name
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_install_program (a_service_name, a_program: STRING)
			-- `nssm_install' `a_service_name' using `a_program'.
			-- By default the service's startup directory will be set
			-- to the directory containing the program.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe install " + a_service_name + " " + a_program
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_start_service (a_service_name: STRING)
			-- `nssm_start_service' `a_service_name'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe start " + a_service_name
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_restart_service (a_service_name: STRING)
			-- `nssm_restart_service' `a_service_name'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe restart " + a_service_name
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_stop_service (a_service_name: STRING)
			-- `nssm_stop_service' `a_service_name'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe stop " + a_service_name
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_service_status (a_service_name: STRING)
			-- `nssm_service_status' `a_service_name'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe status " + a_service_name
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_pause_service (a_service_name: STRING)
			-- `nssm_pause_service' `a_service_name'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe pause " + a_service_name
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_continue_service (a_service_name: STRING)
			-- `nssm_continue_service' `a_service_name'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe continue " + a_service_name
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_rotate_service (a_service_name: STRING)
			-- `nssm_rotate_service' `a_service_name'.
		note
			design: "[
				nssm rotate triggers on-demand rotation for nssm services with I/O redirection 
				and online rotation enabled. nssm accepts user-defined control 128 as a cue to 
				begin output file rotation. Non-nssm services might respond to control 128 in 
				their own way (or ignore it, or crash).
				]"
			EIS: "src=https://nssm.cc/commands"
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe rotate " + a_service_name
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

	nssm_get_service_parameter (a_service_name, a_parameter: STRING): STRING
			-- `nssm_get_service_parameter' `a_service_name' `a_parameter'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe get " + a_service_name + " " + a_parameter
			Result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

feature {TEST_SET_BRIDGE} -- Implementation: Service Removal

	nssm_remove_confirmed (a_service_name: STRING)
			-- `nssm_remove_confirmed' `a_service_name'.
		local
			l_cmd: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_cmd := ".\" + Nssm_path_string + "\nssm.exe remove " + a_service_name + " confirm"
			last_nssm_command_result := output_of_command (l_cmd, l_env.current_working_path.name.out)
		end

feature {TEST_SET_BRIDGE} -- Implementation: Status Report

	last_nssm_command_result: detachable STRING
			-- `last_nssm_command_result'.

	nssm_directory: DIRECTORY
			-- `nssm_directory' as `nssm_relative_path'.
		do
			create Result.make_with_path (nssm_relative_path)
		end

	does_nssm_directory_exist: BOOLEAN
			-- `does_nssm_directory_exist' at `nssm_relative_path'
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
		end

	nssm_exe_run_as_admin: STRING
			-- `nssm_exe_run_as_admin'.
		do
			Result := run_as_admin_with_computer_name.twin
			Result.replace_substring_all ("<<CMD>>", nssm_path_string + "\nssm.exe")
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

	run_as_administrator_cmd_template: STRING = "runas /user:<<LOCAL_MACHINE_NAME>>\administrator <<CMD>>"

	run_as_admin_with_computer_name: STRING
			-- `run_as_admin_with_computer_name' based on `run_as_administrator_cmd_template'.
		local
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			Result := run_as_administrator_cmd_template.twin
			check has_comnputername: attached l_env.item ("COMPUTERNAME") as al_computer_name then
				Result.replace_substring_all ("<<LOCAL_MACHINE_NAME>>", al_computer_name)
			end
		end

invariant
	has_nssm_exe: has_nssm_exe -- Fails due to missing nssm.exe in appropriate subfolder.

note
	design: "[
		This class wraps one of two versions of NSSM (32/64-bit) EXEs.
		]"
	EIS: "name=nssm_home", "src=https://nssm.cc/"
	EIS: "name=nssm_command_line", "src=https://nssm.cc/commands"
end
