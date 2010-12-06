# See License.txt for legal notes.
# Use build.cmd and set there your WDK and SDK directories.

CC=cl
RC=rc
LD=link
MT=mt

!IFDEF x64
BINDIR=..\Release_x64
!ELSE
BINDIR=..\Release
!ENDIF
OBJDIR=$(BINDIR)\obj
APP=$(BINDIR)\Notepad2.exe

SCIINC=..\scintilla\include
SCILEX=..\scintilla\lexers
SCILIB=..\scintilla\lexlib
SCISRC=..\scintilla\src
SCIWIN=..\scintilla\win32
SRC=..\src

DEFINES=/D "STATIC_BUILD" /D "SCI_LEXER" /D "_WINDOWS" /D "NDEBUG" /D "_UNICODE" /D "UNICODE"
INCLUDEDIRS=/I "$(SCIINC)" /I "$(SCILEX)" /I "$(SCILIB)" /I "$(SCISRC)" /I "$(SCIWIN)"
CXXFLAGS=/nologo /c /EHsc /MD /O1 /W3 $(DEFINES) $(INCLUDEDIRS)
RFLAGS=/d "_UNICODE" /d "UNICODE" /d "BOOKMARK_EDITION"
LIBS=kernel32.lib user32.lib gdi32.lib advapi32.lib shell32.lib shlwapi.lib comdlg32.lib \
		comctl32.lib winspool.lib imm32.lib ole32.lib oleaut32.lib psapi.lib
LDFLAGS=/NOLOGO /INCREMENTAL:NO /RELEASE /OPT:REF /OPT:ICF /MERGE:.rdata=.text

!IFDEF x64
CXXFLAGS=$(CXXFLAGS) /D "_WIN64" /D "_WIN32_WINNT=0x0502" /wd4133 /wd4244 /wd4267
RFLAGS=$(RFLAGS) /d "_WIN64"
LIBS=$(LIBS) msvcrt_win2003.obj
LDFLAGS=$(LDFLAGS) /SUBSYSTEM:WINDOWS,5.02 /MACHINE:X64 $(LIBS)
!ELSE
CXXFLAGS=$(CXXFLAGS) /D "WIN32" /D "_WIN32_WINNT=0x0501"
RFLAGS=$(RFLAGS) /d "WIN32"
LIBS=$(LIBS) msvcrt_winxp.obj
LDFLAGS=$(LDFLAGS) /SUBSYSTEM:WINDOWS,5.01 /MACHINE:X86 $(LIBS)
!ENDIF


.PHONY:	ALL CHECKDIRS

CHECKDIRS: $(OBJDIR)

$(OBJDIR):
		-@ MD "$(OBJDIR)" >NUL 2>&1

ALL:	CHECKDIRS $(APP)

CLEAN:
	-@ DEL "$(APP)" "$(OBJDIR)\*.idb" "$(OBJDIR)\*.obj" "$(BINDIR)\*.pdb" \
	"$(OBJDIR)\*.res" >NUL 2>&1
	-@ RMDIR /Q "$(OBJDIR)" "$(BINDIR)" >NUL 2>&1


OBJECTS= \
	$(OBJDIR)\LexAsm.obj \
	$(OBJDIR)\LexConf.obj \
	$(OBJDIR)\LexCPP.obj \
	$(OBJDIR)\LexCSS.obj \
	$(OBJDIR)\LexHTML.obj \
	$(OBJDIR)\LexOthers.obj \
	$(OBJDIR)\LexPascal.obj \
	$(OBJDIR)\LexPerl.obj \
	$(OBJDIR)\LexPowerShell.obj \
	$(OBJDIR)\LexPython.obj \
	$(OBJDIR)\LexSQL.obj \
	$(OBJDIR)\LexVB.obj \
	$(OBJDIR)\Accessor.obj \
	$(OBJDIR)\CharacterSet.obj \
	$(OBJDIR)\LexerBase.obj \
	$(OBJDIR)\LexerModule.obj \
	$(OBJDIR)\LexerSimple.obj \
	$(OBJDIR)\PropSetSimple.obj \
	$(OBJDIR)\StyleContext.obj \
	$(OBJDIR)\WordList.obj \
	$(OBJDIR)\AutoComplete.obj \
	$(OBJDIR)\CallTip.obj \
	$(OBJDIR)\Catalogue.obj \
	$(OBJDIR)\CellBuffer.obj \
	$(OBJDIR)\CharClassify.obj \
	$(OBJDIR)\ContractionState.obj \
	$(OBJDIR)\Decoration.obj \
	$(OBJDIR)\Document.obj \
	$(OBJDIR)\Editor.obj \
	$(OBJDIR)\ExternalLexer.obj \
	$(OBJDIR)\Indicator.obj \
	$(OBJDIR)\KeyMap.obj \
	$(OBJDIR)\LineMarker.obj \
	$(OBJDIR)\PerLine.obj \
	$(OBJDIR)\PositionCache.obj \
	$(OBJDIR)\RESearch.obj \
	$(OBJDIR)\RunStyles.obj \
	$(OBJDIR)\ScintillaBase.obj \
	$(OBJDIR)\Selection.obj \
	$(OBJDIR)\Style.obj \
	$(OBJDIR)\UniConversion.obj \
	$(OBJDIR)\ViewStyle.obj \
	$(OBJDIR)\XPM.obj \
	$(OBJDIR)\PlatWin.obj \
	$(OBJDIR)\ScintillaWin.obj \
	$(OBJDIR)\Dialogs.obj \
	$(OBJDIR)\Dlapi.obj \
	$(OBJDIR)\Edit.obj \
	$(OBJDIR)\Helpers.obj \
	$(OBJDIR)\Notepad2.obj \
	$(OBJDIR)\Print.obj \
	$(OBJDIR)\Styles.obj \
	$(OBJDIR)\Notepad2.res


{$(SCILEX)}.cxx{$(OBJDIR)}.obj:
	@$(CC) $(CXXFLAGS) /Fo"$(OBJDIR)/" /Tp "$<"

{$(SCILIB)}.cxx{$(OBJDIR)}.obj:
	@$(CC) $(CXXFLAGS) /Fo"$(OBJDIR)/" /Tp "$<"

{$(SCISRC)}.cxx{$(OBJDIR)}.obj:
	@$(CC) $(CXXFLAGS) /Fo"$(OBJDIR)/" /Tp "$<"

{$(SCIWIN)}.cxx{$(OBJDIR)}.obj:
	@$(CC) $(CXXFLAGS) /Fo"$(OBJDIR)/" /Tp "$<"

{$(SRC)}.cpp{$(OBJDIR)}.obj:
	@$(CC) $(CXXFLAGS) /Fo"$(OBJDIR)/" /Tp "$<"

{$(SRC)}.c{$(OBJDIR)}.obj:
	@$(CC) $(CXXFLAGS) /Fo"$(OBJDIR)/" /Tc "$<"

{$(SRC)}.rc{$(OBJDIR)}.res:
	@$(RC) $(RFLAGS) /Fo"$@" "$<"


$(APP): $(OBJECTS)
	@$(LD) $(LDFLAGS) /OUT:"$(APP)" $(OBJECTS)
	@"$(MT)" -nologo -manifest "..\res\Notepad2.exe.manifest" -outputresource:"$(APP);#1"


# Dependencies

LEX_HEADERS= $(SCIINC)\ILexer.h $(SCIINC)\Scintilla.h $(SCIINC)\SciLexer.h \
			$(SCILIB)\Accessor.h $(SCILIB)\CharacterSet.h $(SCILIB)\LexAccessor.h \
			$(SCILIB)\LexerModule.h $(SCILIB)\StyleContext.h

# scintilla\lexers
$(OBJDIR)\LexAsm.obj: $(SCILEX)\LexAsm.cxx $(LEX_HEADERS)
$(OBJDIR)\LexConf.obj: $(SCILEX)\LexConf.cxx $(LEX_HEADERS)
$(OBJDIR)\LexCPP.obj: $(SCILEX)\LexCPP.cxx $(LEX_HEADERS)
$(OBJDIR)\LexCSS.obj: $(SCILEX)\LexCSS.cxx $(LEX_HEADERS)
$(OBJDIR)\LexHTML.obj: $(SCILEX)\LexHTML.cxx $(LEX_HEADERS)
$(OBJDIR)\LexOthers.obj: $(SCILEX)\LexOthers.cxx $(LEX_HEADERS)
$(OBJDIR)\LexPascal.obj: $(SCILEX)\LexPascal.cxx $(LEX_HEADERS)
$(OBJDIR)\LexPerl.obj: $(SCILEX)\LexPerl.cxx $(LEX_HEADERS)
$(OBJDIR)\LexPowerShell.obj: $(SCILEX)\LexPowerShell.cxx $(LEX_HEADERS)
$(OBJDIR)\LexPython.obj: $(SCILEX)\LexPython.cxx $(LEX_HEADERS)
$(OBJDIR)\LexSQL.obj: $(SCILEX)\LexSQL.cxx $(LEX_HEADERS)
$(OBJDIR)\LexVB.obj: $(SCILEX)\LexVB.cxx $(LEX_HEADERS)

# scintilla\lexlib
$(OBJDIR)\Accessor.obj: $(SCILIB)\Accessor.cxx $(SCILIB)\Accessor.h
$(OBJDIR)\CharacterSet.obj: $(SCILIB)\CharacterSet.cxx $(SCILIB)\CharacterSet.h
$(OBJDIR)\LexerBase.obj: $(SCILIB)\LexerBase.cxx $(SCILIB)\LexerBase.h
$(OBJDIR)\LexerModule.obj: $(SCILIB)\LexerModule.cxx $(SCILIB)\LexerModule.h
$(OBJDIR)\LexerSimple.obj: $(SCILIB)\LexerSimple.cxx $(SCILIB)\LexerSimple.h
$(OBJDIR)\PropSetSimple.obj: $(SCILIB)\PropSetSimple.cxx $(SCIINC)\Platform.h
$(OBJDIR)\StyleContext.obj: $(SCILIB)\StyleContext.cxx $(SCILIB)\Accessor.h \
	$(SCILIB)\StyleContext.h
$(OBJDIR)\WordList.obj: $(SCILIB)\WordList.cxx $(SCILIB)\WordList.h

# scintilla\src
$(OBJDIR)\AutoComplete.obj: $(SCISRC)\AutoComplete.cxx $(SCIINC)\Platform.h \
	$(SCISRC)\AutoComplete.h
$(OBJDIR)\CallTip.obj: $(SCISRC)\CallTip.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\CallTip.h
$(OBJDIR)\Catalogue.obj: $(SCISRC)\Catalogue.cxx
$(OBJDIR)\CellBuffer.obj: $(SCISRC)\CellBuffer.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\SVector.h $(SCISRC)\SplitVector.h \
	$(SCISRC)\Partitioning.h $(SCISRC)\CellBuffer.h
$(OBJDIR)\CharClassify.obj: $(SCISRC)\CharClassify.cxx $(SCISRC)\CharClassify.h
$(OBJDIR)\ContractionState.obj: $(SCISRC)\ContractionState.cxx \
	$(SCIINC)\Platform.h $(SCISRC)\ContractionState.h
$(OBJDIR)\Decoration.obj: $(SCISRC)\Decoration.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\SplitVector.h $(SCISRC)\Partitioning.h \
	$(SCISRC)\RunStyles.h $(SCISRC)\Decoration.h
$(OBJDIR)\Document.obj: $(SCISRC)\Document.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\SVector.h $(SCISRC)\SplitVector.h \
	$(SCISRC)\Partitioning.h $(SCISRC)\RunStyles.h $(SCISRC)\CellBuffer.h \
	$(SCISRC)\CharClassify.h $(SCISRC)\Decoration.h $(SCISRC)\Document.h \
	$(SCISRC)\RESearch.h $(SCISRC)\PerLine.h
$(OBJDIR)\Editor.obj: $(SCISRC)\Editor.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\ContractionState.h $(SCISRC)\SVector.h \
	$(SCISRC)\SplitVector.h $(SCISRC)\Partitioning.h $(SCISRC)\CellBuffer.h \
	$(SCISRC)\KeyMap.h $(SCISRC)\RunStyles.h $(SCISRC)\Indicator.h \
	$(SCISRC)\XPM.h $(SCISRC)\LineMarker.h $(SCISRC)\Style.h \
	$(SCISRC)\ViewStyle.h $(SCISRC)\CharClassify.h $(SCISRC)\Decoration.h \
	$(SCISRC)\Document.h $(SCISRC)\Editor.h $(SCISRC)\Selection.h \
	$(SCISRC)\PositionCache.h
$(OBJDIR)\ExternalLexer.obj: $(SCISRC)\ExternalLexer.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCIINC)\SciLexer.h $(SCILIB)\Accessor.h \
	$(SCISRC)\ExternalLexer.h
$(OBJDIR)\Indicator.obj: $(SCISRC)\Indicator.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\Indicator.h
$(OBJDIR)\KeyMap.obj: $(SCISRC)\KeyMap.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\KeyMap.h
$(OBJDIR)\LineMarker.obj: $(SCISRC)\LineMarker.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\XPM.h $(SCISRC)\LineMarker.h
$(OBJDIR)\PerLine.obj: $(SCISRC)\PerLine.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\SVector.h $(SCISRC)\SplitVector.h \
	$(SCISRC)\Partitioning.h $(SCISRC)\RunStyles.h $(SCISRC)\PerLine.h
$(OBJDIR)\PositionCache.obj: $(SCISRC)\PositionCache.cxx $(SCISRC)\SplitVector.h \
	$(SCISRC)\Partitioning.h $(SCISRC)\RunStyles.h $(SCISRC)\ContractionState.h \
	$(SCISRC)\CellBuffer.h $(SCISRC)\KeyMap.h $(SCISRC)\Indicator.h \
	$(SCISRC)\XPM.h $(SCISRC)\LineMarker.h $(SCISRC)\Style.h \
	$(SCISRC)\ViewStyle.h $(SCISRC)\CharClassify.h $(SCISRC)\Decoration.h \
	$(SCISRC)\Document.h $(SCISRC)\Selection.h $(SCISRC)\PositionCache.h
$(OBJDIR)\RESearch.obj: $(SCISRC)\RESearch.cxx $(SCISRC)\CharClassify.h \
	$(SCISRC)\RESearch.h
$(OBJDIR)\RunStyles.obj: $(SCISRC)\RunStyles.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\SplitVector.h $(SCISRC)\Partitioning.h \
	$(SCISRC)\RunStyles.h
$(OBJDIR)\ScintillaBase.obj: $(SCISRC)\ScintillaBase.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h \
	$(SCISRC)\ContractionState.h $(SCISRC)\SVector.h $(SCISRC)\SplitVector.h \
	$(SCISRC)\Partitioning.h $(SCISRC)\RunStyles.h $(SCISRC)\CellBuffer.h \
	$(SCISRC)\CallTip.h $(SCISRC)\KeyMap.h $(SCISRC)\Indicator.h \
	$(SCISRC)\XPM.h $(SCISRC)\LineMarker.h $(SCISRC)\Style.h \
	$(SCISRC)\ViewStyle.h $(SCISRC)\AutoComplete.h $(SCISRC)\CharClassify.h \
	$(SCISRC)\Decoration.h $(SCISRC)\Document.h $(SCISRC)\Editor.h \
	$(SCISRC)\Selection.h $(SCISRC)\ScintillaBase.h
$(OBJDIR)\Selection.obj: $(SCISRC)\Selection.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\Selection.h
$(OBJDIR)\Style.obj: $(SCISRC)\Style.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\Style.h
$(OBJDIR)\UniConversion.obj: $(SCISRC)\UniConversion.cxx $(SCISRC)\UniConversion.h
$(OBJDIR)\ViewStyle.obj: $(SCISRC)\ViewStyle.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\SplitVector.h $(SCISRC)\Partitioning.h \
	$(SCISRC)\RunStyles.h $(SCISRC)\Indicator.h $(SCISRC)\XPM.h \
	$(SCISRC)\LineMarker.h $(SCISRC)\Style.h $(SCISRC)\ViewStyle.h
$(OBJDIR)\XPM.obj: $(SCISRC)\XPM.cxx $(SCIINC)\Platform.h $(SCISRC)\XPM.h

# scintilla\win32
$(OBJDIR)\PlatWin.obj: $(SCIWIN)\PlatWin.cxx $(SCIINC)\Platform.h \
	$(SCIWIN)\PlatformRes.h $(SCISRC)\UniConversion.h $(SCISRC)\XPM.h
$(OBJDIR)\ScintillaWin.obj: $(SCIWIN)\ScintillaWin.cxx $(SCIINC)\Platform.h \
	$(SCIINC)\Scintilla.h $(SCISRC)\ContractionState.h $(SCISRC)\SVector.h \
	$(SCISRC)\SplitVector.h $(SCISRC)\Partitioning.h $(SCISRC)\RunStyles.h \
	$(SCISRC)\CellBuffer.h $(SCISRC)\CallTip.h $(SCISRC)\KeyMap.h \
	$(SCISRC)\Indicator.h $(SCISRC)\XPM.h $(SCISRC)\LineMarker.h \
	$(SCISRC)\Style.h $(SCISRC)\AutoComplete.h $(SCISRC)\ViewStyle.h \
	$(SCISRC)\CharClassify.h $(SCISRC)\Decoration.h $(SCISRC)\Document.h \
	$(SCISRC)\Editor.h $(SCISRC)\ScintillaBase.h $(SCISRC)\Selection.h \
	$(SCISRC)\UniConversion.h

# src
$(OBJDIR)\Dialogs.obj: $(SRC)\Dialogs.c $(SRC)\Notepad2.h $(SRC)\Edit.h \
	$(SRC)\Helpers.h $(SRC)\Dlapi.h $(SRC)\Dialogs.h $(SRC)\resource.h
$(OBJDIR)\Dlapi.obj: $(SRC)\Dlapi.c $(SRC)\Dlapi.h
$(OBJDIR)\Edit.obj: $(SRC)\Edit.c $(SRC)\Notepad2.h $(SRC)\Helpers.h \
	$(SRC)\Dialogs.h $(SRC)\Styles.h $(SRC)\Edit.h $(SRC) $(SRC)\resource.h
$(OBJDIR)\Helpers.obj: $(SRC)\Helpers.c $(SRC)\Helpers.h
$(OBJDIR)\Notepad2.obj: $(SRC)\Notepad2.c $(SRC)\Edit.h $(SRC)\Styles.h \
	$(SRC)\Helpers.h $(SRC)\Dialogs.h $(SRC)\Notepad2.h $(SRC)\resource.h
$(OBJDIR)\Notepad2.res: $(SRC)\Notepad2.rc
$(OBJDIR)\Print.obj: $(SRC)\Print.cpp $(SRC)\Dialogs.h $(SRC)\Helpers.h \
	$(SRC)\resource.h
$(OBJDIR)\Styles.obj: $(SRC)\Styles.c $(SRC)\Dialogs.h $(SRC)\Helpers.h \
	$(SRC)\Notepad2.h $(SRC)\Edit.h $(SRC)\Styles.h $(SRC)\resource.h