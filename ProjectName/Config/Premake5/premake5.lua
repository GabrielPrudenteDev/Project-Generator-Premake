os.chdir('../../')

WorkspaceName = path.getbasename(os.getcwd())
ProjectName = WorkspaceName
TargetName = ProjectName

TargetPath = 'Binaries/%{cfg.platform}/%{cfg.buildcfg}'
ObjectPath = 'Intermediate/Build'
LocationPath = 'Intermediate/ProjectFiles'
SymbolsPath = 'Intermediate/Symbols/$(TargetName).pdb'
ContentPath = '"' .. path.getabsolute('Content') .. '/"'

-- App       => .exe
-- StaticLib => .lib
-- SharedLib => .dll

function CopyContentFiles()
    FilesFrom = path.getabsolute("Content")
    FileTo = path.getabsolute(TargetPath .. '/Content')
    postbuildmessage "Copying Content Files..."
    -- copy a file from the objects directory to the target directory
    postbuildcommands { "{COPYDIR} %{FilesFrom} %{FileTo}" }
end

workspace(WorkspaceName)

    configurations {'App-Debug', 'App-Release', 'App-Shipping', 'StaticLib-Debug', 'StaticLib-Release', 'StaticLib-Shipping', 'SharedLib-Debug', 'SharedLib-Release', 'SharedLib-Shipping'}
    platforms {'Win32', 'Win64'}

project(ProjectName).group = 'Application'

    language ("C++")
    kind ('ConsoleApp')
    targetdir (TargetPath)
    objdir (ObjectPath)
    location (LocationPath)
    symbolspath (SymbolsPath)
    os.mkdir('Content')
    os.mkdir('Source/' .. ProjectName)

    includedirs ('Source', 'Source/' .. ProjectName)
    includedirs ('Config/ThirdParty/Include')

    files {'Config/AppIcon/Resource.rc'}
    files {'Source/**.h', 'Source/**.c', 'Source/**.hpp', 'Source/**.cpp'}

    vpaths {
        ['Config/*'] = {'Config/AppIcon/Resouce.rc'},
        ["Source/*"] = {'Source/**.h', 'Source/**.c', 'Source/**.hpp', 'Source/**.cpp'}
    }

--APP FILTER
    filter {'configurations:App-Debug'}
        defines {'DEBUG_MODE'}
        defines {'CONTENT_PATH=' .. ContentPath}
        symbols 'On'
        optimize 'Off'

    filter {'configurations:App-Release'}
        defines {'RELEASE_MODE'}
        defines {'CONTENT_PATH=' .. ContentPath}
        symbols 'Off'
        optimize 'On'

    filter {'configurations:App-Shipping'}
        defines {'SHIPPING_MODE'}
        defines {'CONTENT_PATH="Content/"'}
        symbols 'Off'
        optimize 'On'
        CopyContentFiles()

--STATIC LIB FILTER
    filter {'configurations:StaticLib-Debug'}
        kind ('StaticLib')
        defines {'DEBUG_MODE'}
        defines {'CONTENT_PATH=' .. ContentPath}
        symbols 'On'
        optimize 'Off'

    filter {'configurations:StaticLib-Release'}
        kind ('StaticLib')
        defines {'RELEASE_MODE'}
        defines {'CONTENT_PATH=' .. ContentPath}
        symbols 'Off'
        optimize 'On'

    filter {'configurations:StaticLib-Shipping'}
        kind ('StaticLib')
        defines {'SHIPPING_MODE'}
        defines {'CONTENT_PATH="Content/"'}
        symbols 'Off'
        optimize 'On'
        CopyContentFiles()

--SHARED LIB FILTER
    filter {'configurations:SharedLib-Debug'}
        kind ('SharedLib')
        defines {'DEBUG_MODE'}
        defines {'CONTENT_PATH=' .. ContentPath}
        symbols 'On'
        optimize 'Off'

    filter {'configurations:SharedLib-Release'}
        kind ('SharedLib')
        defines {'RELEASE_MODE'}
        defines {'CONTENT_PATH=' .. ContentPath}
        symbols 'Off'
        optimize 'On'

    filter {'configurations:SharedLib-Shipping'}
        kind ('SharedLib')
        defines {'SHIPPING_MODE'}
        defines {'CONTENT_PATH="Content/"'}
        symbols 'Off'
        optimize 'On'
        CopyContentFiles()

-- FILTER PLATFORMS
    filter {'platforms:Win32'}
        architecture ("x86")
        system 'Windows'
        libdirs { 'Config/ThirdParty/Lib/Win64' }

    filter {'platforms:Win64'}
        architecture ("x86_64")
        system 'Windows'
        libdirs { 'Config/ThirdParty/Lib/Win64' }

-- FILTER SYSTEMS
    filter "system:Unix"
        defines {'PLATFORM_UNIX'}
        system "linux"
        cppdialect "gnu++17"
        
    filter "system:Windows"
        defines {'PLATFORM_WINDOWS'}
        system "windows"
        --links { "raylib.lib" }
        cppdialect "C++17"

    filter "system:Mac"
        defines {'PLATFORM_MAC'}
        system "macosx"

    filter {}

-- GENERATOR

    include "ProjectSettings.lua"

    newaction {
        trigger     = "GeneratorVs2017",
        description = "Install the software",
        execute     = function ()
            Filename = "../../Project.bat";
            Content = SettingsString
            Content = Content:gsub("PROJECTNAME", WorkspaceName)
            Content = Content:gsub("VSVERSION", "vs2017")
            Content = Content:gsub("VSPATH", Vs2017Path)
            io.writefile(Filename, Content)
        end
    }

    newaction {
        trigger     = "GeneratorVs2019",
        description = "Install the software",
        execute     = function ()
            Filename = "../../Project.bat";
            Content = SettingsString
            Content = Content:gsub("PROJECTNAME", WorkspaceName)
            Content = Content:gsub("VSVERSION", "vs2019")
            Content = Content:gsub("VSPATH", Vs2019Path)
            io.writefile(Filename, Content)
        end
    }

    newaction {
        trigger     = "GeneratorVs2022",
        description = "Install the software",
        execute     = function ()
            Filename = "../../Project.bat";
            Content = SettingsString
            Content = Content:gsub("PROJECTNAME", WorkspaceName)
            Content = Content:gsub("VSVERSION", "vs2022")
            Content = Content:gsub("VSPATH", Vs2022Path)
            io.writefile(Filename, Content)
        end
     }

