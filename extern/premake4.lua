solution "Extern"
	location(_WORKING_DIR)

	if os.get() == "macosx" then
		platforms { "Universal" }
	end

	configurations { "Debug", "Release" }

	configuration "Debug"
    	flags { "Symbols" }
		targetsuffix "_d"
    configuration "Release"
    	flags { "OptimizeSpeed", "NoFramePointer" }


	dofile("extern.lua")
