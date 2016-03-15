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

end


