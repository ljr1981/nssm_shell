note
	description: "[
		An application EXE to be used only as a temporary "test_service".
		]"
	design: "[
		We will use this EXE to test the NSSM against by way of an Eiffel
		application. We want to install, remove, manipulate, run, and otherwise
		utilize NSSM Windows Services. This EXE helps prove that system.
		]"

class
	SERVICE_APPLICATION

inherit
	LE_LOGGING_AWARE

create
	make

feature {NONE} -- Initialization

	make
			-- `make' Current.
		local
			l_end,
			l_now: DATE_TIME
			n: INTEGER
		do
			from
				create l_end.make_now
				l_end.add (create {DATE_TIME_DURATION}.make_definite (0, 0, 1, 0))
				create l_now.make_now
				n := 100_000
			variant
				n
			until
				l_now > l_end
			loop
				n := n - 1
				create l_now.make_now
				logger.write_information ("It is ALIVE at " + (create {DATE_TIME}.make_now).out)
			end
		end

end
