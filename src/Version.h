/******************************************************************************
*
* Notepad2-mod
*
* Version.h
*
* See License.txt for details about distribution and modification.
*
*                                       (c) XhmikosR 2010-2017
*                                       https://github.com/XhmikosR/notepad2-mod
*
*
******************************************************************************/


#ifndef NOTEPAD2_VERSION_H
#define NOTEPAD2_VERSION_H


#ifndef _T
#if !defined(ISPP_INVOKED) && (defined(UNICODE) || defined(_UNICODE))
#define _T(text) L##text
#else
#define _T(text) text
#endif
#endif

#define DO_STRINGIFY(x) _T(#x)
#define STRINGIFY(x)    DO_STRINGIFY(x)

#define VERSION_MAJOR   2019
#define VERSION_MINOR   12
#define VERSION_BUILD   12
#define VERSION_REV		999

#define MY_APPNAME                   L"notepad"
#define VERSION_FILEVERSION_NUM      VERSION_MAJOR,VERSION_MINOR,VERSION_BUILD,VERSION_REV
#define VERSION_FILEVERSION          STRINGIFY(VERSION_MAJOR) "." STRINGIFY(VERSION_MINOR) "." \
                                     STRINGIFY(VERSION_BUILD) "." STRINGIFY(VERSION_REV)

#define VERSION_LEGALCOPYRIGHT_SHORT L"Copyright ? 2004-2019"
#define VERSION_LEGALCOPYRIGHT_LONG  L"Florian Balmer 2004-2016"
#define VERSION_AUTHORNAME           L"Sam Sanchez"
#define VERSION_SCINTILLA            L"v4.2.3"
#define VERSION_EMAILDISPLAY         L""
#define VERSION_COMPANYNAME          L"Notepad Org"
#define VERSION_WEBPAGEDISPLAY       L"http://www.flos-freeware.ch"
#define VERSION_MOD_PAGE             L"https://github.com/XhmikosR/notepad2-mod"
#define VERSION_MOD_PAGE2            L"https://github.com/yahasana/notepad"

#if defined(_WIN64)
   #define VERSION_FILEVERSION_LONG  L"notepad (x64) " STRINGIFY(VERSION_MAJOR) L"." \
                                     STRINGIFY(VERSION_MINOR) L"." STRINGIFY(VERSION_BUILD) \
                                     L" r" STRINGIFY(VERSION_REV)
#else
   #define VERSION_FILEVERSION_LONG  L"notepad " STRINGIFY(VERSION_MAJOR) L"."         \
                                     STRINGIFY(VERSION_MINOR) L"." STRINGIFY(VERSION_BUILD) 
//\                                  L" r" STRINGIFY(VERSION_REV)
#endif

// Compiler specific
#if defined(_MSC_VER)
    #if _MSC_VER == 1924
        #define VERSION_COMPILER    L"MSVC 2019"
    #elif _MSC_VER == 1900
        #if (_MSC_FULL_VER == 190024215)
            #define VERSION_COMPILER    L"MSVC 2015 Update 3"
        #elif (_MSC_FULL_VER < 190023026)
            #define VERSION_COMPILER    L"MSVC 2015 Preview/Beta/RC"
        #else
            #define VERSION_COMPILER    L"MSVC 2015"
        #endif
    #elif _MSC_VER == 1800
        #if (_MSC_FULL_VER == 180040629)
            #define VERSION_COMPILER    L"MSVC 2013 Update 5"
        #elif (_MSC_FULL_VER == 180031101)
            #define VERSION_COMPILER    L"MSVC 2013 Update 4"
        #elif (_MSC_FULL_VER == 180030723)
            #define VERSION_COMPILER    L"MSVC 2013 Update 3"
        #elif (_MSC_FULL_VER == 180030501)
            #define VERSION_COMPILER    L"MSVC 2013 Update 2"
        #elif (_MSC_FULL_VER < 180021005)
            #define VERSION_COMPILER    L"MSVC 2013 Preview/Beta/RC"
        #else
            #define VERSION_COMPILER    L"MSVC 2013"
        #endif
    #elif _MSC_VER == 1700
        #if (_MSC_FULL_VER == 170061030)
            #define VERSION_COMPILER    L"MSVC 2012 Update 4"
        #elif (_MSC_FULL_VER == 170060610)
            #define VERSION_COMPILER    L"MSVC 2012 Update 3"
        #elif (_MSC_FULL_VER == 170060315)
            #define VERSION_COMPILER    L"MSVC 2012 Update 2"
        #elif (_MSC_FULL_VER == 170051106)
            #define VERSION_COMPILER    L"MSVC 2012 Update 1"
        #elif (_MSC_FULL_VER < 170050727)
            #define VERSION_COMPILER    L"MSVC 2012 Beta/RC/PR"
        #else
            #define VERSION_COMPILER    L"MSVC 2012"
        #endif
    #elif _MSC_VER == 1600
        #if (_MSC_FULL_VER >= 160040219)
            #define VERSION_COMPILER    L"MSVC 2010 SP1"
        #else
            #define VERSION_COMPILER    L"MSVC 2010"
        #endif
    #elif _MSC_VER == 1500
        #if (_MSC_FULL_VER >= 150030729)
            #define VERSION_COMPILER    L"MSVC 2008 SP1"
        #else
            #define VERSION_COMPILER    L"MSVC 2008"
        #endif
    #else
        #define VERSION_COMPILER        L"MSVC (version unknown)"
    #endif
#else
    #define VERSION_COMPILER            L"(Unknown compiler)"
#endif

#endif // NOTEPAD2_VERSION_H
