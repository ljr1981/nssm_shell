note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	NSSM_ACCESSOR_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	nssm_32_test
			-- `nssm_test'
		local
			l_nssm: NSSM_ACCESSOR_32
		do
			create l_nssm
			l_nssm.nssm_relative_path.do_nothing
		end

	nssm_64_test
			-- `nssm_test'
		local
			l_nssm: NSSM_ACCESSOR_64
		do
			create l_nssm
			l_nssm.nssm_relative_path.do_nothing
		end

	environment_test
			-- `environment_test'.
		local
			l_nssm: NSSM_ACCESSOR_32
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			create l_nssm
			check has_env: attached l_env.item ("COMPUTERNAME") as al_computer_name then
				assert_strings_equal ("has_computer_name", "runas /user:" + al_computer_name + "\administrator <<CMD>>", l_nssm.run_as_admin_with_computer_name)
			end
		end

	install_and_removal_test
			-- `install_and_removal_test'.
		local
			l_nssm: NSSM_ACCESSOR_32
			l_install,
			l_remove: detachable STRING
		do
			create l_nssm
			l_nssm.nssm_install_program ("test_service", "C:\Users\lrix\Documents\GitHub\nssm_shell\test_service.exe")
			l_install := l_nssm.last_nssm_command_result
			l_nssm.nssm_remove_confirmed ("test_service")
			l_remove := l_nssm.last_nssm_command_result
		end

end


