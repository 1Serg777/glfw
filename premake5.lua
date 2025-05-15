project ( "glfw" )
    kind      ( "StaticLib" )
    language  ( "C" )
    location  ( build_path .. "/glfw" )
    targetdir ( build_path .. "/bin/" .. target_dir )
    objdir    ( build_path .. "/bin-int/" .. obj_dir )

    includedirs {
        "%{include_dirs.glfw}",
    }

    files {
        "%{include_dirs.glfw}/**.h",
        "%{include_dirs.glfw}/**.m",
        "%{src_dirs.glfw}/**.c",
    }

    filter ( "system:linux" )
        defines ( {
            --"_CRT_SECURE_NO_WARNINGS",
            "_GLFW_WAYLAND",
            "_GLFW_X11"
        })

    filter ( "system:windows" )
        defines ( {
            "_CRT_SECURE_NO_WARNINGS",
            "_GLFW_WIN32"
        })

    filter ( { "system:windows", "action:vs*" } )
        vpaths {
            ["Include/*"] = {
                "%{include_dirs.glfw}/**.h",
                "%{include_dirs.glfw}/**.m",
            },
            ["Sources/*"] = {
                "%{src_dirs.glfw}/**.c"
            },
        }

    filter ( "configurations:Debug" )
        defines ( { "DEBUG", "_DEBUG" } )
        runtime ( "Debug" )
        symbols ( "On" )

    filter ( "configurations:Release" )
        defines  ( { "NDEBUG", "_NDEBUG" } )
        runtime  ( "Release" )
        optimize ( "On" )