project "sigc++"
	kind "SharedLib"
	language "C++"
	includedirs { "libsigc++-2.3.1" }
	defines { "PIC=1" }
	files {
		"libsigc++-2.3.1/sigc++/signal.cc",
		"libsigc++-2.3.1/sigc++/signal_base.cc",
		"libsigc++-2.3.1/sigc++/trackable.cc",
		"libsigc++-2.3.1/sigc++/connection.cc",
		"libsigc++-2.3.1/sigc++/functors/slot.cc",
		"libsigc++-2.3.1/sigc++/functors/slot_base.cc",
		"libsigc++-2.3.1/sigc++/adaptors/lambda/lambda.cc",
	}

project "PhysFS"
	kind "SharedLib"
	language "C++"

	includedirs {
		"physfs-2.0.3",
		"physfs-2.0.3/zlib123",
	}

	defines {
		"HAVE_ASSERT_H=1",
		"PHYSFS_HAVE_SYS_UCRED_H=1",
		"PHYSFS_SUPPORTS_7Z=1",
		"PHYSFS_SUPPORTS_GRP=1",
		"PHYSFS_SUPPORTS_HOG=1",
		"PHYSFS_SUPPORTS_MVL=1",
		"PHYSFS_SUPPORTS_QPAK=1",
		"PHYSFS_SUPPORTS_WAD=1",
		"PHYSFS_SUPPORTS_ZIP=1",
		"Z_PREFIX=1",
		"_REENTRANT=1",
		"_THREAD_SAFE=1",
		"physfs_EXPORTS=1",
	}

	files {
		"physfs-2.0.3/physfs.c",
		"physfs-2.0.3/physfs_byteorder.c",
		"physfs-2.0.3/physfs_unicode.c",
		"physfs-2.0.3/platform/os2.c",
		"physfs-2.0.3/platform/pocketpc.c",
		"physfs-2.0.3/platform/posix.c",
		"physfs-2.0.3/platform/unix.c",
		"physfs-2.0.3/platform/macosx.c",
		"physfs-2.0.3/platform/windows.c",
		"physfs-2.0.3/archivers/dir.c",
		"physfs-2.0.3/archivers/grp.c",
		"physfs-2.0.3/archivers/hog.c",
		"physfs-2.0.3/archivers/lzma.c",
		"physfs-2.0.3/archivers/mvl.c",
		"physfs-2.0.3/archivers/qpak.c",
		"physfs-2.0.3/archivers/wad.c",
		"physfs-2.0.3/archivers/zip.c",
		"physfs-2.0.3/lzma/C/7zCrc.c",
		"physfs-2.0.3/lzma/C/Archive/7z/7zBuffer.c",
		"physfs-2.0.3/lzma/C/Archive/7z/7zDecode.c",
		"physfs-2.0.3/lzma/C/Archive/7z/7zExtract.c",
		"physfs-2.0.3/lzma/C/Archive/7z/7zHeader.c",
		"physfs-2.0.3/lzma/C/Archive/7z/7zIn.c",
		"physfs-2.0.3/lzma/C/Archive/7z/7zItem.c",
		"physfs-2.0.3/lzma/C/Archive/7z/7zMethodID.c",
		"physfs-2.0.3/lzma/C/Compress/Branch/BranchX86.c",
		"physfs-2.0.3/lzma/C/Compress/Branch/BranchX86_2.c",
		"physfs-2.0.3/lzma/C/Compress/Lzma/LzmaDecode.c",
		"physfs-2.0.3/zlib123/adler32.c",
		"physfs-2.0.3/zlib123/compress.c",
		"physfs-2.0.3/zlib123/crc32.c",
		"physfs-2.0.3/zlib123/deflate.c",
		"physfs-2.0.3/zlib123/gzio.c",
		"physfs-2.0.3/zlib123/infback.c",
		"physfs-2.0.3/zlib123/inffast.c",
		"physfs-2.0.3/zlib123/inflate.c",
		"physfs-2.0.3/zlib123/inftrees.c",
		"physfs-2.0.3/zlib123/trees.c",
		"physfs-2.0.3/zlib123/uncompr.c",
		"physfs-2.0.3/zlib123/zutil.c"
	}

	if os.get() == "macosx" then
		links { "CoreFoundation.framework", "Carbon.framework", "CoreServices.framework", "IOKit.framework" }
	end

if os.get() == "windows" or os.get() == "android" then
	project "OpenAL"
		kind "SharedLib"
		language "C"
		defines { "AL_BUILD_LIBRARY", "AL_ALEXT_PROTOTYPES" }
		includedirs {
			"openal-soft/include",
			"openal-soft/OpenAL32/Include"
		}
		files {
			"openal-soft/OpenAL32/alAuxEffectSlot.c",
			"openal-soft/OpenAL32/alBuffer.c",
			"openal-soft/OpenAL32/alDatabuffer.c",
			"openal-soft/OpenAL32/alEffect.c",
			"openal-soft/OpenAL32/alError.c",
			"openal-soft/OpenAL32/alExtension.c",
			"openal-soft/OpenAL32/alFilter.c",
			"openal-soft/OpenAL32/alListener.c",
			"openal-soft/OpenAL32/alSource.c",
			"openal-soft/OpenAL32/alState.c",
			"openal-soft/OpenAL32/alThunk.c",
			"openal-soft/Alc/ALc.c",
			"openal-soft/Alc/ALu.c",
			"openal-soft/Alc/alcConfig.c",
			"openal-soft/Alc/alcEcho.c",
			"openal-soft/Alc/alcModulator.c",
			"openal-soft/Alc/alcReverb.c",
			"openal-soft/Alc/alcRing.c",
			"openal-soft/Alc/alcThread.c",
			"openal-soft/Alc/bs2b.c",
			"openal-soft/Alc/mixer.c",
			"openal-soft/Alc/panning.c",
			"openal-soft/Alc/null.c"
		}
		
		configuration { "android" }
			includedirs { 
				"openal-soft/android/jni" 
			}
			files {
				"openal-soft/Alc/android.c",
			}
			links {
				"log"
			}

		configuration { "windows" }
			defines {
				"strcasecmp=_stricmp",
				"strncasecmp=_strnicmp",
				"snprintf=_snprintf",
				"vsnprintf=_vsnprintf",
				"isnan=_isnan",
			}

			includedirs { "openal-soft/include/windows" }
			files {
				"openal-soft/Alc/winmm.c",
				"openal-soft/Alc/dsound.c"
			}

			links { "winmm", "dsound" }
end

project "SDL2"
	
	kind "SharedLib"
	language "C"

	includedirs {
		"SDL2-2.0.3/include",
	}

	defines {
		--"USING_GENERATED_CONFIG_H=1",
		"TARGET_API_MAC_CARBON=1",
		"TARGET_API_MAC_OSX=1",
		"_THREAD_SAFE=1",
		"PIC=1",
	}

	files {
		"SDL2-2.0.3/src/SDL.c",
		"SDL2-2.0.3/src/SDL_assert.c",
		"SDL2-2.0.3/src/SDL_error.c",
		"SDL2-2.0.3/src/SDL_hints.c",
		"SDL2-2.0.3/src/SDL_log.c",
		"SDL2-2.0.3/src/atomic/SDL_atomic.c",
		"SDL2-2.0.3/src/atomic/SDL_spinlock.c",
		"SDL2-2.0.3/src/audio/SDL_audio.c",
		"SDL2-2.0.3/src/audio/SDL_audiocvt.c",
		"SDL2-2.0.3/src/audio/SDL_audiodev.c",
		"SDL2-2.0.3/src/audio/SDL_audiotypecvt.c",
		"SDL2-2.0.3/src/audio/SDL_mixer.c",
		"SDL2-2.0.3/src/audio/SDL_wave.c",
		"SDL2-2.0.3/src/cpuinfo/SDL_cpuinfo.c",
		"SDL2-2.0.3/src/dynapi/SDL_dynapi.c",
		"SDL2-2.0.3/src/events/SDL_clipboardevents.c",
		"SDL2-2.0.3/src/events/SDL_dropevents.c",
		"SDL2-2.0.3/src/events/SDL_events.c",
		"SDL2-2.0.3/src/events/SDL_gesture.c",
		"SDL2-2.0.3/src/events/SDL_keyboard.c",
		"SDL2-2.0.3/src/events/SDL_mouse.c",
		"SDL2-2.0.3/src/events/SDL_quit.c",
		"SDL2-2.0.3/src/events/SDL_touch.c",
		"SDL2-2.0.3/src/events/SDL_windowevents.c",
		"SDL2-2.0.3/src/file/SDL_rwops.c",
		"SDL2-2.0.3/src/haptic/SDL_haptic.c",
		"SDL2-2.0.3/src/joystick/SDL_gamecontroller.c",
		"SDL2-2.0.3/src/joystick/SDL_joystick.c",
		"SDL2-2.0.3/src/libm/e_atan2.c",
		"SDL2-2.0.3/src/libm/e_log.c",
		"SDL2-2.0.3/src/libm/e_pow.c",
		"SDL2-2.0.3/src/libm/e_rem_pio2.c",
		"SDL2-2.0.3/src/libm/e_sqrt.c",
		"SDL2-2.0.3/src/libm/k_cos.c",
		"SDL2-2.0.3/src/libm/k_rem_pio2.c",
		"SDL2-2.0.3/src/libm/k_sin.c",
		"SDL2-2.0.3/src/libm/s_atan.c",
		"SDL2-2.0.3/src/libm/s_copysign.c",
		"SDL2-2.0.3/src/libm/s_cos.c",
		"SDL2-2.0.3/src/libm/s_fabs.c",
		"SDL2-2.0.3/src/libm/s_floor.c",
		"SDL2-2.0.3/src/libm/s_scalbn.c",
		"SDL2-2.0.3/src/libm/s_sin.c",
		"SDL2-2.0.3/src/power/SDL_power.c",
		"SDL2-2.0.3/src/render/SDL_d3dmath.c",
		"SDL2-2.0.3/src/render/SDL_render.c",
		"SDL2-2.0.3/src/render/SDL_yuv_mmx.c",
		"SDL2-2.0.3/src/render/SDL_yuv_sw.c",
		"SDL2-2.0.3/src/render/direct3d/SDL_render_d3d.c",
		"SDL2-2.0.3/src/render/direct3d11/SDL_render_d3d11.c",
		"SDL2-2.0.3/src/render/opengl/SDL_render_gl.c",
		"SDL2-2.0.3/src/render/opengl/SDL_shaders_gl.c",
		"SDL2-2.0.3/src/render/opengles/SDL_render_gles.c",
		"SDL2-2.0.3/src/render/opengles2/SDL_render_gles2.c",
		"SDL2-2.0.3/src/render/opengles2/SDL_shaders_gles2.c",
		"SDL2-2.0.3/src/render/psp/SDL_render_psp.c",
		"SDL2-2.0.3/src/render/software/SDL_blendfillrect.c",
		"SDL2-2.0.3/src/render/software/SDL_blendline.c",
		"SDL2-2.0.3/src/render/software/SDL_blendpoint.c",
		"SDL2-2.0.3/src/render/software/SDL_drawline.c",
		"SDL2-2.0.3/src/render/software/SDL_drawpoint.c",
		"SDL2-2.0.3/src/render/software/SDL_render_sw.c",
		"SDL2-2.0.3/src/render/software/SDL_rotate.c",
		"SDL2-2.0.3/src/stdlib/SDL_getenv.c",
		"SDL2-2.0.3/src/stdlib/SDL_iconv.c",
		"SDL2-2.0.3/src/stdlib/SDL_malloc.c",
		"SDL2-2.0.3/src/stdlib/SDL_qsort.c",
		"SDL2-2.0.3/src/stdlib/SDL_stdlib.c",
		"SDL2-2.0.3/src/stdlib/SDL_string.c",
		"SDL2-2.0.3/src/thread/SDL_thread.c",
		"SDL2-2.0.3/src/timer/SDL_timer.c",
		"SDL2-2.0.3/src/video/SDL_RLEaccel.c",
		"SDL2-2.0.3/src/video/SDL_blit.c",
		"SDL2-2.0.3/src/video/SDL_blit_0.c",
		"SDL2-2.0.3/src/video/SDL_blit_1.c",
		"SDL2-2.0.3/src/video/SDL_blit_A.c",
		"SDL2-2.0.3/src/video/SDL_blit_N.c",
		"SDL2-2.0.3/src/video/SDL_blit_auto.c",
		"SDL2-2.0.3/src/video/SDL_blit_copy.c",
		"SDL2-2.0.3/src/video/SDL_blit_slow.c",
		"SDL2-2.0.3/src/video/SDL_bmp.c",
		"SDL2-2.0.3/src/video/SDL_clipboard.c",
		"SDL2-2.0.3/src/video/SDL_egl.c",
		"SDL2-2.0.3/src/video/SDL_fillrect.c",
		"SDL2-2.0.3/src/video/SDL_pixels.c",
		"SDL2-2.0.3/src/video/SDL_rect.c",
		"SDL2-2.0.3/src/video/SDL_shape.c",
		"SDL2-2.0.3/src/video/SDL_stretch.c",
		"SDL2-2.0.3/src/video/SDL_surface.c",
		"SDL2-2.0.3/src/video/SDL_video.c",
		"SDL2-2.0.3/src/video/dummy/SDL_nullevents.c",
		"SDL2-2.0.3/src/video/dummy/SDL_nullframebuffer.c",
		"SDL2-2.0.3/src/video/dummy/SDL_nullvideo.c",
		"SDL2-2.0.3/src/audio/disk/SDL_diskaudio.c",
		"SDL2-2.0.3/src/audio/dummy/SDL_dummyaudio.c",
		"SDL2-2.0.3/src/loadso/dlopen/SDL_sysloadso.c",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoaclipboard.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoaevents.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoakeyboard.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoamessagebox.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoamodes.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoamouse.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoamousetap.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoaopengl.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoashape.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoavideo.m",
		"SDL2-2.0.3/src/video/cocoa/SDL_cocoawindow.m",
		"SDL2-2.0.3/src/thread/pthread/SDL_systhread.c",
		"SDL2-2.0.3/src/thread/pthread/SDL_syssem.c",
		"SDL2-2.0.3/src/thread/pthread/SDL_sysmutex.c",
		"SDL2-2.0.3/src/thread/pthread/SDL_syscond.c",
		"SDL2-2.0.3/src/thread/pthread/SDL_systls.c",
		"SDL2-2.0.3/src/audio/coreaudio/SDL_coreaudio.c",
		"SDL2-2.0.3/src/joystick/darwin/SDL_sysjoystick.c",
		"SDL2-2.0.3/src/haptic/darwin/SDL_syshaptic.c",
		"SDL2-2.0.3/src/power/macosx/SDL_syspower.c",
		"SDL2-2.0.3/src/filesystem/cocoa/SDL_sysfilesystem.m",
		"SDL2-2.0.3/src/timer/unix/SDL_systimer.c",
		"SDL2-2.0.3/src/file/cocoa/SDL_rwopsbundlesupport.m",
		"SDL2-2.0.3/src/main/dummy/SDL_dummy_main.c",
	}

	if os.get() == "macosx" then
		links { "Cocoa.framework", "CoreFoundation.framework", "Carbon.framework", "CoreAudio.framework", "AudioUnit.framework", "ForceFeedback.framework", "CoreServices.framework", "IOKit.framework", "iconv" }
	end

project "SDL2_image"
	kind "SharedLib"
	language "C"
	includedirs { 
		"SDL2_image-2.0.0",
		"SDL2-2.0.3/include",
		"SDL2_image-2.0.0/external/jpeg-9",
		"SDL2_image-2.0.0/external/libpng-1.6.2",
	}

	defines {
		"PACKAGE_NAME=\\\"\\\"",
		"PACKAGE_TARNAME=\\\"\\\"",
		"PACKAGE_VERSION=\\\"\\\"",
		"PACKAGE_STRING=\\\"\\\"",
		"PACKAGE_BUGREPORT=\\\"\\\"",
		"PACKAGE_URL=\\\"\\\"",
		"STDC_HEADERS=1",
		"HAVE_SYS_TYPES_H=1",
		"HAVE_SYS_STAT_H=1",
		"HAVE_STDLIB_H=1",
		"HAVE_STRING_H=1",
		"HAVE_MEMORY_H=1",
		"HAVE_STRINGS_H=1",
		"HAVE_INTTYPES_H=1",
		"HAVE_STDINT_H=1",
		"HAVE_UNISTD_H=1",
		"HAVE_DLFCN_H=1",
		"LT_OBJDIR=\\\".libs/\\\"",
		"PACKAGE=\\\"SDL2_image\\\"",
		"VERSION=\\\"2.0.0\\\"",
		"LOAD_BMP=1",
		"LOAD_JPG=1",
		"LOAD_PNG=1",
		"SDL_IMAGE_USE_COMMON_BACKEND=1",
		"_THREAD_SAFE=1",
		"PIC=1",
	}

	files {
		"SDL2_image-2.0.0/IMG.c",
		"SDL2_image-2.0.0/IMG_bmp.c",
		"SDL2_image-2.0.0/IMG_gif.c",
		"SDL2_image-2.0.0/IMG_jpg.c",
		"SDL2_image-2.0.0/IMG_lbm.c",
		"SDL2_image-2.0.0/IMG_pcx.c",
		"SDL2_image-2.0.0/IMG_png.c",
		"SDL2_image-2.0.0/IMG_pnm.c",
		"SDL2_image-2.0.0/IMG_tga.c",
		"SDL2_image-2.0.0/IMG_tif.c",
		"SDL2_image-2.0.0/IMG_xcf.c",
		"SDL2_image-2.0.0/IMG_xpm.c",
		"SDL2_image-2.0.0/IMG_xv.c",
		"SDL2_image-2.0.0/IMG_webp.c",
		"SDL2_image-2.0.0/showimage.c",


		"SDL2_image-2.0.0/external/jpeg-9/jaricom.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcapimin.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcapistd.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcarith.c",
		"SDL2_image-2.0.0/external/jpeg-9/jccoefct.c",
		"SDL2_image-2.0.0/external/jpeg-9/jccolor.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcdctmgr.c",
		"SDL2_image-2.0.0/external/jpeg-9/jchuff.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcinit.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcmainct.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcmarker.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcmaster.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcomapi.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcparam.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcprepct.c",
		"SDL2_image-2.0.0/external/jpeg-9/jcsample.c",
		"SDL2_image-2.0.0/external/jpeg-9/jctrans.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdapimin.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdapistd.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdarith.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdatadst.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdatasrc.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdcoefct.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdcolor.c",
		"SDL2_image-2.0.0/external/jpeg-9/jddctmgr.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdhuff.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdinput.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdmainct.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdmarker.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdmaster.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdmerge.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdpostct.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdsample.c",
		"SDL2_image-2.0.0/external/jpeg-9/jdtrans.c",
		"SDL2_image-2.0.0/external/jpeg-9/jerror.c",
		"SDL2_image-2.0.0/external/jpeg-9/jfdctflt.c",
		"SDL2_image-2.0.0/external/jpeg-9/jfdctfst.c",
		"SDL2_image-2.0.0/external/jpeg-9/jfdctint.c",
		"SDL2_image-2.0.0/external/jpeg-9/jidctflt.c",
		"SDL2_image-2.0.0/external/jpeg-9/jidctfst.c",
		"SDL2_image-2.0.0/external/jpeg-9/jidctint.c",
		"SDL2_image-2.0.0/external/jpeg-9/jquant1.c",
		"SDL2_image-2.0.0/external/jpeg-9/jquant2.c",
		"SDL2_image-2.0.0/external/jpeg-9/jutils.c",
		"SDL2_image-2.0.0/external/jpeg-9/jmemmgr.c",
		"SDL2_image-2.0.0/external/jpeg-9/jmemansi.c",

		"SDL2_image-2.0.0/external/libpng-1.6.2/png.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngerror.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngget.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngmem.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngpread.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngread.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngrio.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngrtran.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngrutil.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngset.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngtrans.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngwio.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngwrite.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngwtran.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngwutil.c",
		"SDL2_image-2.0.0/external/libpng-1.6.2/png.h",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngconf.h",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngdebug.h",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pnginfo.h",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngpriv.h",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngstruct.h",
		"SDL2_image-2.0.0/external/libpng-1.6.2/pngusr.dfa",
	}

	links { "SDL2", "z" }

project "SDL2_ttf"
	kind "SharedLib"
	language "C"
	defines {
		"FT2_BUILD_LIBRARY",
		"FT_CONFIG_OPTION_SYSTEM_ZLIB",
		"PACKAGE_NAME=\\\"\\\"",
		"PACKAGE_TARNAME=\\\"\\\"",
		"PACKAGE_VERSION=\\\"\\\"",
		"PACKAGE_STRING=\\\"\\\"",
		"PACKAGE_BUGREPORT=\\\"\\\"",
		"PACKAGE_URL=\\\"\\\"",
		"STDC_HEADERS=1",
		"HAVE_SYS_TYPES_H=1",
		"HAVE_SYS_STAT_H=1",
		"HAVE_STDLIB_H=1",
		"HAVE_STRING_H=1",
		"HAVE_MEMORY_H=1",
		"HAVE_STRINGS_H=1",
		"HAVE_INTTYPES_H=1",
		"HAVE_STDINT_H=1",
		"HAVE_UNISTD_H=1",
		"HAVE_DLFCN_H=1",
		"LT_OBJDIR=\\\".libs/\\\"",
		"PACKAGE=\\\"SDL2_ttf\\\"",
		"VERSION=\\\"2.0.12\\\"",
		"HAVE_ALLOCA_H=1",
		"HAVE_ALLOCA=1",
		"_THREAD_SAFE=1",
		"HAVE_OPENGL=1",
		"PIC=1",
	}

	includedirs { 
		"SDL2-2.0.3/include",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/include",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/truetype",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/autofit",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/smooth",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/raster",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/psaux",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/psnames",
	}

	files {
		"SDL2_ttf-2.0.12/SDL_ttf.c",

		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/autofit/autofit.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftadvanc.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftbbox.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftbitmap.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftcalc.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftcid.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftdbgmem.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftdebug.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftfstype.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftgasp.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftgloadr.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftglyph.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftgxval.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftinit.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftlcdfil.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftmm.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftobjs.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftotval.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftoutln.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftpatent.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftpfr.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftrfork.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftsnames.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftstream.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftstroke.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftsynth.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftsystem.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/fttrigon.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/fttype1.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftutil.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftwinfnt.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/base/ftxf86.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/bdf/bdf.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/bzip2/ftbzip2.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/cache/ftcache.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/cff/cff.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/cid/type1cid.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/gzip/ftgzip.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/lzw/ftlzw.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/pcf/pcf.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/pfr/pfr.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/psaux/psaux.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/pshinter/pshinter.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/psnames/psmodule.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/raster/raster.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/sfnt/sfnt.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/smooth/smooth.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/truetype/truetype.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/type1/type1.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/type42/type42.c",
		"SDL2_ttf-2.0.12/external/freetype-2.4.12/src/winfonts/winfnt.c"
	}

	links { "SDL2", "z" }


project "SDL2_sound"
	kind "SharedLib"
	language "C"
	defines {
		"STDC_HEADERS=1",
		"HAVE_SYS_TYPES_H=1",
		"HAVE_SYS_STAT_H=1",
		"HAVE_STDLIB_H=1",
		"HAVE_STRING_H=1",
		"HAVE_MEMORY_H=1",
		"HAVE_STRINGS_H=1",
		"HAVE_INTTYPES_H=1",
		"HAVE_STDINT_H=1",
		"HAVE_UNISTD_H=1",
		"HAVE_DLFCN_H=1",
		"HAVE_ALLOCA_H=1",
		"HAVE_ALLOCA=1",
		"_THREAD_SAFE=1",
		"PIC=1",

		"SOUND_SUPPORTS_WAV",
		--"SOUND_SUPPORTS_MPG123",
		--"SOUND_SUPPORTS_OGG"
	}

	includedirs {
		"SDL_sound",
		"SDL2-2.0.3/include",
	}

	files {
		"SDL_sound/SDL_sound.c",
		"SDL_sound/audio_convert.c",
		--"SDL_sound/decoders/mpg123.c",
		--"SDL_sound/decoders/ogg.c",
		"SDL_sound/decoders/wav.c",
	}

	links { "SDL2" }

project "pixman"
	kind "SharedLib"
	language "C"

	defines {
		"STDC_HEADERS=1",
		"HAVE_SYS_TYPES_H=1",
		"HAVE_SYS_STAT_H=1",
		"HAVE_STDLIB_H=1",
		"HAVE_STRING_H=1",
		"HAVE_MEMORY_H=1",
		"HAVE_STRINGS_H=1",
		"HAVE_INTTYPES_H=1",
		"HAVE_STDINT_H=1",
		"HAVE_UNISTD_H=1",
		"HAVE_DLFCN_H=1",
		"HAVE_ALLOCA_H=1",
		"HAVE_ALLOCA=1",
		"HAVE_PTHREADS=1",
		"PACKAGE=\\\"pixman\\\"",
		"PIC",
	}

	includedirs {
		"pixman-0.32.4/pixman",
	}

	files {
		"pixman-0.32.4/pixman/pixman.c",
		"pixman-0.32.4/pixman/pixman-access.c",
		"pixman-0.32.4/pixman/pixman-access-accessors.c",
		"pixman-0.32.4/pixman/pixman-bits-image.c",
		"pixman-0.32.4/pixman/pixman-combine32.c",
		"pixman-0.32.4/pixman/pixman-combine-float.c",
		"pixman-0.32.4/pixman/pixman-conical-gradient.c",
		"pixman-0.32.4/pixman/pixman-filter.c",
		"pixman-0.32.4/pixman/pixman-x86.c",
		"pixman-0.32.4/pixman/pixman-mips.c",
		"pixman-0.32.4/pixman/pixman-arm.c",
		"pixman-0.32.4/pixman/pixman-ppc.c",
		"pixman-0.32.4/pixman/pixman-edge.c",
		"pixman-0.32.4/pixman/pixman-edge-accessors.c",
		"pixman-0.32.4/pixman/pixman-fast-path.c",
		"pixman-0.32.4/pixman/pixman-glyph.c",
		"pixman-0.32.4/pixman/pixman-general.c",
		"pixman-0.32.4/pixman/pixman-gradient-walker.c",
		"pixman-0.32.4/pixman/pixman-image.c",
		"pixman-0.32.4/pixman/pixman-implementation.c",
		"pixman-0.32.4/pixman/pixman-linear-gradient.c",
		"pixman-0.32.4/pixman/pixman-matrix.c",
		"pixman-0.32.4/pixman/pixman-noop.c",
		"pixman-0.32.4/pixman/pixman-radial-gradient.c",
		"pixman-0.32.4/pixman/pixman-region16.c",
		"pixman-0.32.4/pixman/pixman-region32.c",
		"pixman-0.32.4/pixman/pixman-solid-fill.c",
		"pixman-0.32.4/pixman/pixman-timer.c",
		"pixman-0.32.4/pixman/pixman-trap.c",
		"pixman-0.32.4/pixman/pixman-utils.c",
		"pixman-0.32.4/pixman/pixman-mmx.c",
		"pixman-0.32.4/pixman/pixman-sse2.c",
		"pixman-0.32.4/pixman/pixman-ssse3.c",
	}

project "ruby"
	kind "SharedLib"
	language "C"

	defines {
		"_FORTIFY_SOURCE=2",
		"RUBY_EXPORT",
		"_XOPEN_SOURCE",
		"_DARWIN_C_SOURCE",
		"_DARWIN_UNLIMITED_SELECT",
		"_REENTRANT",
	}

	includedirs {
		"ruby-2.1.2",
		"ruby-2.1.2/include",
		"ruby-2.1.2/lib",
	}

	files {
		"ruby-2.1.2/dln.c",
		"ruby-2.1.2/localeinit.c",
		"ruby-2.1.2/main.c",
		"ruby-2.1.2/dmydln.c",
		"ruby-2.1.2/miniinit.c",
		"ruby-2.1.2/miniprelude.c",
		"ruby-2.1.2/array.c",
		"ruby-2.1.2/bignum.c",
		"ruby-2.1.2/class.c",
		"ruby-2.1.2/compar.c",
		"ruby-2.1.2/complex.c",
		"ruby-2.1.2/dir.c",
		"ruby-2.1.2/dln_find.c",
		"ruby-2.1.2/encoding.c",
		"ruby-2.1.2/enum.c",
		"ruby-2.1.2/enumerator.c",
		"ruby-2.1.2/error.c",
		"ruby-2.1.2/eval.c",
		"ruby-2.1.2/load.c",
		"ruby-2.1.2/proc.c",
		"ruby-2.1.2/file.c",
		"ruby-2.1.2/gc.c",
		"ruby-2.1.2/hash.c",
		"ruby-2.1.2/inits.c",
		"ruby-2.1.2/io.c",
		"ruby-2.1.2/marshal.c",
		"ruby-2.1.2/math.c",
		"ruby-2.1.2/node.c",
		"ruby-2.1.2/numeric.c",
		"ruby-2.1.2/object.c",
		"ruby-2.1.2/pack.c",
		"ruby-2.1.2/parse.c",
		"ruby-2.1.2/process.c",
		"ruby-2.1.2/random.c",
		"ruby-2.1.2/range.c",
		"ruby-2.1.2/rational.c",
		"ruby-2.1.2/re.c",
		"ruby-2.1.2/regcomp.c",
		"ruby-2.1.2/regenc.c",
		"ruby-2.1.2/regerror.c",
		"ruby-2.1.2/regexec.c",
		"ruby-2.1.2/regparse.c",
		"ruby-2.1.2/regsyntax.c",
		"ruby-2.1.2/ruby.c",
		"ruby-2.1.2/safe.c",
		"ruby-2.1.2/signal.c",
		"ruby-2.1.2/sprintf.c",
		"ruby-2.1.2/st.c",
		"ruby-2.1.2/strftime.c",
		"ruby-2.1.2/string.c",
		"ruby-2.1.2/struct.c",
		"ruby-2.1.2/time.c",
		"ruby-2.1.2/transcode.c",
		"ruby-2.1.2/util.c",
		"ruby-2.1.2/variable.c",
		"ruby-2.1.2/version.c",
		"ruby-2.1.2/compile.c",
		"ruby-2.1.2/debug.c",
		"ruby-2.1.2/iseq.c",
		"ruby-2.1.2/vm.c",
		"ruby-2.1.2/vm_dump.c",
		"ruby-2.1.2/vm_backtrace.c",
		"ruby-2.1.2/vm_trace.c",
		"ruby-2.1.2/thread.c",
		"ruby-2.1.2/cont.c",
		"ruby-2.1.2/enc/ascii.c",
		"ruby-2.1.2/enc/us_ascii.c",
		"ruby-2.1.2/enc/unicode.c",
		"ruby-2.1.2/enc/utf_8.c",
		"ruby-2.1.2/newline.c",
		"ruby-2.1.2/missing/setproctitle.c",
		"ruby-2.1.2/dmyext.c",
		"ruby-2.1.2/loadpath.c",
		"ruby-2.1.2/prelude.c",
		"ruby-2.1.2/prelude.c",
	}
