note
	description: "Summary description for {NSSM_ACCESSOR_64}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NSSM_ACCESSOR_64

inherit
	NSSM_ACCESSOR_32
		redefine
			nssm_path_string
		end

feature {TEST_SET_BRIDGE} -- Implementation: Constants

	nssm_path_string: STRING
			-- `nssm_relative_path_string' for Current.
		once
			Result := "nssm-" + nssm_version_string + "\" + nssm_win64_folder_name_string
		end

end
