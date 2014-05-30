solution "mkxp"
	location(_WORKING_DIR)
	targetdir(_WORKING_DIR)

	if os.get() == "macosx" then
		platforms { "Universal" }
	end

	configurations{ "Debug", "Release" }

	configuration "Debug"
    	flags { "Symbols" }
		targetsuffix "_d"
    configuration "Release"
    	flags { "OptimizeSpeed", "NoFramePointer" }

	project "mkxp"

		language "C++"
		kind "WindowedApp"

		defines {
			"FILE_OFFSET_BITS=64"
		}

		files {
			"src/quadarray.h",
			"src/audio.h",
			"src/binding.h",
			"src/bitmap.h",
			"src/disposable.h",
			"src/etc.h",
			"src/etc-internal.h",
			"src/eventthread.h",
			"src/flashable.h",
			"src/font.h",
			"src/input.h",
			"src/plane.h",
			"src/scene.h",
			"src/sprite.h",
			"src/table.h",
			"src/texpool.h",
			"src/tilequad.h",
			"src/transform.h",
			"src/viewport.h",
			"src/window.h",
			"src/serializable.h",
			"src/shader.h",
			"src/glstate.h",
			"src/quad.h",
			"src/tilemap.h",
			"src/graphics.h",
			"src/debuglogger.h",
			"src/global-ibo.h",
			"src/exception.h",
			"src/filesystem.h",
			"src/serial-util.h",
			"src/intrulist.h",
			"src/binding.h",
			"src/gl-util.h",
			"src/util.h",
			"src/config.h",
			"src/tileatlas.h",
			"src/perftimer.h",
			"src/sharedstate.h",
			"src/al-util.h",
			"src/boost-hash.h",
			"src/debugwriter.h",

			"src/main.cpp",
			"src/audio.cpp",
			"src/bitmap.cpp",
			"src/eventthread.cpp",
			"src/filesystem.cpp",
			"src/font.cpp",
			"src/input.cpp",
			"src/plane.cpp",
			"src/scene.cpp",
			"src/sprite.cpp",
			"src/table.cpp",
			"src/tilequad.cpp",
			"src/viewport.cpp",
			"src/window.cpp",
			"src/texpool.cpp",
			"src/shader.cpp",
			"src/glstate.cpp",
			"src/tilemap.cpp",
			"src/autotiles.cpp",
			"src/graphics.cpp",
			"src/debuglogger.cpp",
			"src/etc.cpp",
			"src/config.cpp",
			"src/tileatlas.cpp",
			"src/perftimer.cpp",
			"src/sharedstate.cpp",

			"binding-mri/binding-util.h",
			"binding-mri/binding-types.h",
			"binding-mri/serializable-binding.h",
			"binding-mri/disposable-binding.h",
			"binding-mri/sceneelement-binding.h",
			"binding-mri/viewportelement-binding.h",
			"binding-mri/flashable-binding.h",

			"binding-mri/binding-mri.cpp",
			"binding-mri/binding-util.cpp",
			"binding-mri/table-binding.cpp",
			"binding-mri/etc-binding.cpp",
			"binding-mri/bitmap-binding.cpp",
			"binding-mri/font-binding.cpp",
			"binding-mri/graphics-binding.cpp",
			"binding-mri/input-binding.cpp",
			"binding-mri/sprite-binding.cpp",
			"binding-mri/viewport-binding.cpp",
			"binding-mri/plane-binding.cpp",
			"binding-mri/window-binding.cpp",
			"binding-mri/tilemap-binding.cpp",
			"binding-mri/audio-binding.cpp",
			"binding-mri/module_rpg.cpp",
			"binding-mri/filesystem-binding.cpp",
		}

		assets {
			"shader/transSimple.frag",
			"shader/trans.frag",
			"shader/hue.frag",
			"shader/sprite.frag",
			"shader/plane.frag",
			"shader/bitmapBlit.frag",
			"shader/simple.frag",
			"shader/simpleColor.frag",
			"shader/simpleAlpha.frag",
			"shader/flashMap.frag",
			"shader/simple.vert",
			"shader/simpleColor.vert",
			"shader/sprite.vert",
			"assets/liberation.ttf",

			"shader/blur.frag",
			"shader/blurH.vert",
			"shader/blurV.vert",
			"shader/simpleMatrix.vert"
		}
	
		includedirs {
			"extern/boost-1.55.0",
			"extern/glew-1.10.0/include",
			"extern/libsigc++-2.3.1",
			"extern/physfs/src",
			"extern/pixman-0.32.4/pixman",
			"extern/SDL_sound",
			"extern/SDL2_image-2.0.0",
			"extern/SDL2_ttf-2.0.12",
			"extern/SDL2-2.0.3/include",
			"extern/ruby-2.1.2/include",
		}

		libdirs { "extern" }

		links { "boost", "glew", "sigc++", "pixman", "PhysFS", "SDL2", "SDL2_image", "SDL2_ttf", "SDL_sound", "OpenGL.framework", "OpenAL.framework", "ruby", "z" }

		dofile("extern/extern.lua")

