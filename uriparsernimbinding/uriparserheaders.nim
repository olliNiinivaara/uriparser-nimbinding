
# Generated @ 2020-11-18T10:39:31+02:00
# Command line:
#   /home/olli/.nimble/pkgs/nimterop-0.6.13/nimterop/toast -r -n ./uriparser/Uri.h -o=uriparser.nim

# const 'URI_INLINE' has unsupported value 'inline'
# const 'URI_CHAR' has unsupported value 'char'
# const 'URI_STRLEN' has unsupported value 'strlen'
# const 'URI_STRCPY' has unsupported value 'strcpy'
# const 'URI_STRCMP' has unsupported value 'strcmp'
# const 'URI_STRNCMP' has unsupported value 'strncmp'
# const 'URI_SNPRINTF' has unsupported value 'snprintf'
# const 'URI_VER_SUFFIX_UNICODE' has unsupported value 'URI_ANSI_TO_UNICODE(URI_VER_SUFFIX_ANSI)'
# const 'URI_VER_ANSI' has unsupported value 'URI_VER_ANSI_HELPER(URI_VER_MAJOR, URI_VER_MINOR, URI_VER_RELEASE, URI_VER_SUFFIX_ANSI)'
# const 'URI_VER_UNICODE' has unsupported value 'URI_VER_UNICODE_HELPER(URI_VER_MAJOR, URI_VER_MINOR, URI_VER_RELEASE, URI_VER_SUFFIX_UNICODE)'
# const 'URI_ERROR_NULL' has unsupported value '2 /* One of the params passed was NULL'
# tree-sitter parse error: 'although it mustn't', skipped
# const 'URI_ERROR_TOSTRING_TOO_LONG' has unsupported value 'URI_ERROR_OUTPUT_TOO_LARGE /* Deprecated, test for URI_ERROR_OUTPUT_TOO_LARGE instead */'
# const 'URI_CHAR' has unsupported value 'wchar_t'
# const 'URI_STRLEN' has unsupported value 'wcslen'
# const 'URI_STRCPY' has unsupported value 'wcscpy'
# const 'URI_STRCMP' has unsupported value 'wcscmp'
# const 'URI_STRNCMP' has unsupported value 'wcsncmp'
# const 'URI_SNPRINTF' has unsupported value 'swprintf'
{.push hint[ConvFromXtoItselfNotNeeded]: off.}
import macros

macro defineEnum(typ: untyped): untyped =
  result = newNimNode(nnkStmtList)

  # Enum mapped to distinct cint
  result.add quote do:
    type `typ`* = distinct cint

  for i in ["+", "-", "*", "div", "mod", "shl", "shr", "or", "and", "xor", "<", "<=", "==", ">", ">="]:
    let
      ni = newIdentNode(i)
      typout = if i[0] in "<=>": newIdentNode("bool") else: typ # comparisons return bool
    if i[0] == '>': # cannot borrow `>` and `>=` from templates
      let
        nopp = if i.len == 2: newIdentNode("<=") else: newIdentNode("<")
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` = `nopp`(y, x)
        proc `ni`*(x: cint, y: `typ`): `typout` = `nopp`(y, x)
        proc `ni`*(x, y: `typ`): `typout` = `nopp`(y, x)
    else:
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` {.borrow.}
        proc `ni`*(x: cint, y: `typ`): `typout` {.borrow.}
        proc `ni`*(x, y: `typ`): `typout` {.borrow.}
    result.add quote do:
      proc `ni`*(x: `typ`, y: int): `typout` = `ni`(x, y.cint)
      proc `ni`*(x: int, y: `typ`): `typout` = `ni`(x.cint, y)

  let
    divop = newIdentNode("/")   # `/`()
    dlrop = newIdentNode("$")   # `$`()
    notop = newIdentNode("not") # `not`()
  result.add quote do:
    proc `divop`*(x, y: `typ`): `typ` = `typ`((x.float / y.float).cint)
    proc `divop`*(x: `typ`, y: cint): `typ` = `divop`(x, `typ`(y))
    proc `divop`*(x: cint, y: `typ`): `typ` = `divop`(`typ`(x), y)
    proc `divop`*(x: `typ`, y: int): `typ` = `divop`(x, y.cint)
    proc `divop`*(x: int, y: `typ`): `typ` = `divop`(x.cint, y)

    proc `dlrop`*(x: `typ`): string {.borrow.}
    proc `notop`*(x: `typ`): `typ` {.borrow.}

when defined(cpp):
  # http://www.cplusplus.com/reference/cwchar/wchar_t/
  # In C++, wchar_t is a distinct fundamental type (and thus it is
  # not defined in <cwchar> nor any other header).
  type wchar_t* {.importc.} = object
else:
  type wchar_t* {.importc, header:"stddef.h".} = object


{.pragma: impUriHdr, header: "/home/olli/Nim/uriparser/uriparser/Uri.h".}
{.experimental: "codeReordering".}
defineEnum(UriBreakConversionEnum) ## ```
                                   ##   < @copydoc UriMemoryManagerStruct 
                                   ##     
                                   ##    Specifies a line break conversion mode.
                                   ## ```
defineEnum(UriNormalizationMaskEnum) ## ```
                                     ##   < @copydoc UriBreakConversionEnum 
                                     ##     
                                     ##    Specifies which component of a %URI has to be normalized.
                                     ## ```
defineEnum(UriResolutionOptionsEnum) ## ```
                                     ##   < @copydoc UriNormalizationMaskEnum 
                                     ##     
                                     ##    Specifies how to resolve %URI references.
                                     ## ```
const
  URI_DEFS_CONFIG_H* = 1
  URI_ENABLE_ANSI* = 1
  URI_ENABLE_UNICODE* = 1
  URI_PASS_ANSI* = 1
  URI_H_ANSI* = 1
  URI_BASE_H* = 1
  URI_VER_MAJOR* = 0
  URI_VER_MINOR* = 9
  URI_VER_RELEASE* = 4
  URI_VER_SUFFIX_ANSI* = ""
  URI_TRUE* = 1
  URI_FALSE* = 0
  URI_SUCCESS* = 0
  URI_ERROR_SYNTAX* = 1
  URI_ERROR_MALLOC* = 3
  URI_ERROR_OUTPUT_TOO_LARGE* = 4
  URI_ERROR_NOT_IMPLEMENTED* = 8
  URI_ERROR_RANGE_INVALID* = 9
  URI_ERROR_MEMORY_MANAGER_INCOMPLETE* = 10
  URI_ERROR_ADDBASE_REL_BASE* = 5
  URI_ERROR_REMOVEBASE_REL_BASE* = 6
  URI_ERROR_REMOVEBASE_REL_SOURCE* = 7
  URI_ERROR_MEMORY_MANAGER_FAULTY* = 11
  URI_BR_TO_LF* = (0).UriBreakConversionEnum ## ```
                                             ##   < Convert to Unix line breaks ("\\x0a")
                                             ## ```
  URI_BR_TO_CRLF* = (URI_BR_TO_LF + 1).UriBreakConversionEnum ## ```
                                                              ##   < Convert to Windows line breaks ("\\x0d\\x0a")
                                                              ## ```
  URI_BR_TO_CR* = (URI_BR_TO_CRLF + 1).UriBreakConversionEnum ## ```
                                                              ##   < Convert to Macintosh line breaks ("\\x0d")
                                                              ## ```
  URI_BR_TO_UNIX* = (URI_BR_TO_LF).UriBreakConversionEnum ## ```
                                                          ##   < @copydoc UriBreakConversionEnum::URI_BR_TO_LF
                                                          ## ```
  URI_BR_TO_WINDOWS* = (URI_BR_TO_CRLF).UriBreakConversionEnum ## ```
                                                               ##   < @copydoc UriBreakConversionEnum::URI_BR_TO_CRLF
                                                               ## ```
  URI_BR_TO_MAC* = (URI_BR_TO_CR).UriBreakConversionEnum ## ```
                                                         ##   < @copydoc UriBreakConversionEnum::URI_BR_TO_CR
                                                         ## ```
  URI_BR_DONT_TOUCH* = (URI_BR_TO_MAC + 1).UriBreakConversionEnum ## ```
                                                                  ##   < Copy line breaks unmodified
                                                                  ## ```
  URI_NORMALIZED* = (0).UriNormalizationMaskEnum ## ```
                                                 ##   < Do not normalize anything
                                                 ## ```
  URI_NORMALIZE_SCHEME* = (1 shl typeof(1)(0)).UriNormalizationMaskEnum ## ```
                                                                        ##   < Normalize scheme (fix uppercase letters)
                                                                        ## ```
  URI_NORMALIZE_USER_INFO* = (1 shl typeof(1)(1)).UriNormalizationMaskEnum ## ```
                                                                           ##   < Normalize user info (fix uppercase percent-encodings)
                                                                           ## ```
  URI_NORMALIZE_HOST* = (1 shl typeof(1)(2)).UriNormalizationMaskEnum ## ```
                                                                      ##   < Normalize host (fix uppercase letters)
                                                                      ## ```
  URI_NORMALIZE_PATH* = (1 shl typeof(1)(3)).UriNormalizationMaskEnum ## ```
                                                                      ##   < Normalize path (fix uppercase percent-encodings and redundant dot segments)
                                                                      ## ```
  URI_NORMALIZE_QUERY* = (1 shl typeof(1)(4)).UriNormalizationMaskEnum ## ```
                                                                       ##   < Normalize query (fix uppercase percent-encodings)
                                                                       ## ```
  URI_NORMALIZE_FRAGMENT* = (1 shl typeof(1)(5)).UriNormalizationMaskEnum ## ```
                                                                          ##   < Normalize fragment (fix uppercase percent-encodings)
                                                                          ## ```
  URI_RESOLVE_STRICTLY* = (0).UriResolutionOptionsEnum ## ```
                                                       ##   < Full RFC conformance
                                                       ## ```
  URI_RESOLVE_IDENTICAL_SCHEME_COMPAT* = (1 shl typeof(1)(0)).UriResolutionOptionsEnum ## ```
                                                                                       ##   < Treat %URI to resolve with identical scheme as having no scheme
                                                                                       ## ```
  URI_PASS_UNICODE* = 1
  URI_H_UNICODE* = 1
type
  UriBool* {.importc, impUriHdr.} = cint ## ```
                                         ##   < Boolean type
                                         ## ```
  UriIp4Struct* {.bycopy, impUriHdr, importc: "struct UriIp4Struct".} = object ## ```
                                                                                ##   Holds an IPv4 address.
                                                                                ## ```
    data*: array[4, cuchar]  ## ```
                             ##   < Each octet in one byte
                             ## ```
  
  UriIp4* {.importc, impUriHdr.} = UriIp4Struct ## ```
                                                ##   Holds an IPv4 address.
                                                ## ```
  UriIp6Struct* {.bycopy, impUriHdr, importc: "struct UriIp6Struct".} = object ## ```
                                                                                ##   < @copydoc UriIp4Struct 
                                                                                ##     
                                                                                ##    Holds an IPv6 address.
                                                                                ## ```
    data*: array[16, cuchar] ## ```
                             ##   < Each quad in two bytes
                             ## ```
  
  UriIp6* {.importc, impUriHdr.} = UriIp6Struct ## ```
                                                ##   < @copydoc UriIp4Struct 
                                                ##     
                                                ##    Holds an IPv6 address.
                                                ## ```
  UriMemoryManagerStruct* {.bycopy, impUriHdr,
                            importc: "struct UriMemoryManagerStruct".} = object
    malloc*: UriFuncMalloc   ## ```
                             ##   < Pointer to custom malloc(3)
                             ## ```
    calloc*: UriFuncCalloc ## ```
                           ##   < Pointer to custom calloc(3); to emulate using malloc and memset see uriEmulateCalloc
                           ## ```
    realloc*: UriFuncRealloc ## ```
                             ##   < Pointer to custom realloc(3)
                             ## ```
    reallocarray*: UriFuncReallocarray ## ```
                                       ##   < Pointer to custom reallocarray(3); to emulate using realloc see uriEmulateReallocarray
                                       ## ```
    free*: UriFuncFree       ## ```
                             ##   < Pointer to custom free(3)
                             ## ```
    userData*: pointer ## ```
                       ##   < Pointer to data that the other function members need access to
                       ## ```
  
  UriFuncMalloc* {.importc, impUriHdr.} = proc (a1: ptr UriMemoryManagerStruct;
      a2: uint): pointer {.cdecl.}
  UriFuncCalloc* {.importc, impUriHdr.} = proc (a1: ptr UriMemoryManagerStruct;
      a2: uint; a3: uint): pointer {.cdecl.}
  UriFuncRealloc* {.importc, impUriHdr.} = proc (a1: ptr UriMemoryManagerStruct;
      a2: pointer; a3: uint): pointer {.cdecl.}
  UriFuncReallocarray* {.importc, impUriHdr.} = proc (
      a1: ptr UriMemoryManagerStruct; a2: pointer; a3: uint; a4: uint): pointer {.
      cdecl.}
  UriFuncFree* {.importc, impUriHdr.} = proc (a1: ptr UriMemoryManagerStruct;
      a2: pointer) {.cdecl.}
  UriMemoryManager* {.importc, impUriHdr.} = UriMemoryManagerStruct ## ```
                                                                    ##   Class-like interface of custom memory managers
                                                                    ##   
                                                                    ##    @see uriCompleteMemoryManager
                                                                    ##    @see uriEmulateCalloc
                                                                    ##    @see uriEmulateReallocarray
                                                                    ##    @see uriTestMemoryManager
                                                                    ##    @since 0.9.0
                                                                    ## ```
  UriBreakConversion* {.importc, impUriHdr.} = UriBreakConversionEnum ## ```
                                                                      ##   < @copydoc UriMemoryManagerStruct 
                                                                      ##     
                                                                      ##    Specifies a line break conversion mode.
                                                                      ## ```
  UriNormalizationMask* {.importc, impUriHdr.} = UriNormalizationMaskEnum ## ```
                                                                          ##   < @copydoc UriBreakConversionEnum 
                                                                          ##     
                                                                          ##    Specifies which component of a %URI has to be normalized.
                                                                          ## ```
  UriResolutionOptions* {.importc, impUriHdr.} = UriResolutionOptionsEnum ## ```
                                                                          ##   < @copydoc UriNormalizationMaskEnum 
                                                                          ##     
                                                                          ##    Specifies how to resolve %URI references.
                                                                          ## ```
  UriTextRangeStructA* {.bycopy, impUriHdr,
                         importc: "struct UriTextRangeStructA".} = object ## ```
                                                                           ##   Specifies a range of characters within a string.
                                                                           ##    The range includes all characters from <c>first</c>
                                                                           ##    to one before <c>afterLast</c>. So if both are
                                                                           ##    non-NULL the difference is the length of the text range.
                                                                           ##   
                                                                           ##    @see UriUriA
                                                                           ##    @see UriPathSegmentA
                                                                           ##    @see UriHostDataA
                                                                           ##    @since 0.3.0
                                                                           ## ```
    first*: cstring          ## ```
                             ##   < Pointer to first character
                             ## ```
    afterLast*: cstring ## ```
                        ##   < Pointer to character after the last one still in
                        ## ```
  
  UriTextRangeA* {.importc, impUriHdr.} = UriTextRangeStructA ## ```
                                                              ##   Specifies a range of characters within a string.
                                                              ##    The range includes all characters from <c>first</c>
                                                              ##    to one before <c>afterLast</c>. So if both are
                                                              ##    non-NULL the difference is the length of the text range.
                                                              ##   
                                                              ##    @see UriUriA
                                                              ##    @see UriPathSegmentA
                                                              ##    @see UriHostDataA
                                                              ##    @since 0.3.0
                                                              ## ```
  UriPathSegmentStructA* {.bycopy, impUriHdr,
                           importc: "struct UriPathSegmentStructA".} = object ## ```
                                                                               ##   < @copydoc UriTextRangeStructA 
                                                                               ##     
                                                                               ##    Represents a path segment within a %URI path.
                                                                               ##    More precisely it is a node in a linked
                                                                               ##    list of path segments.
                                                                               ##   
                                                                               ##    @see UriUriA
                                                                               ##    @since 0.3.0
                                                                               ## ```
    text*: UriTextRangeA     ## ```
                             ##   < Path segment name
                             ## ```
    next*: ptr UriPathSegmentStructA ## ```
                                     ##   < Pointer to the next path segment in the list, can be NULL if last already
                                     ## ```
    reserved*: pointer       ## ```
                             ##   < Reserved to the parser
                             ## ```
  
  UriPathSegmentA* {.importc, impUriHdr.} = UriPathSegmentStructA ## ```
                                                                  ##   < @copydoc UriTextRangeStructA 
                                                                  ##     
                                                                  ##    Represents a path segment within a %URI path.
                                                                  ##    More precisely it is a node in a linked
                                                                  ##    list of path segments.
                                                                  ##   
                                                                  ##    @see UriUriA
                                                                  ##    @since 0.3.0
                                                                  ## ```
  UriHostDataStructA* {.bycopy, impUriHdr, importc: "struct UriHostDataStructA".} = object ## ```
                                                                                            ##   < @copydoc UriPathSegmentStructA 
                                                                                            ##     
                                                                                            ##    Holds structured host information.
                                                                                            ##    This is either a IPv4, IPv6, plain
                                                                                            ##    text for IPvFuture or all zero for
                                                                                            ##    a registered name.
                                                                                            ##   
                                                                                            ##    @see UriUriA
                                                                                            ##    @since 0.3.0
                                                                                            ## ```
    ip4*: ptr UriIp4         ## ```
                             ##   < IPv4 address
                             ## ```
    ip6*: ptr UriIp6         ## ```
                             ##   < IPv6 address
                             ## ```
    ipFuture*: UriTextRangeA ## ```
                             ##   < IPvFuture address
                             ## ```
  
  UriHostDataA* {.importc, impUriHdr.} = UriHostDataStructA ## ```
                                                            ##   < @copydoc UriPathSegmentStructA 
                                                            ##     
                                                            ##    Holds structured host information.
                                                            ##    This is either a IPv4, IPv6, plain
                                                            ##    text for IPvFuture or all zero for
                                                            ##    a registered name.
                                                            ##   
                                                            ##    @see UriUriA
                                                            ##    @since 0.3.0
                                                            ## ```
  UriUriStructA* {.bycopy, impUriHdr, importc: "struct UriUriStructA".} = object ## ```
                                                                                  ##   < @copydoc UriHostDataStructA 
                                                                                  ##     
                                                                                  ##    Represents an RFC 3986 %URI.
                                                                                  ##    Missing components can be {NULL, NULL} ranges.
                                                                                  ##   
                                                                                  ##    @see uriFreeUriMembersA
                                                                                  ##    @see uriFreeUriMembersMmA
                                                                                  ##    @see UriParserStateA
                                                                                  ##    @since 0.3.0
                                                                                  ## ```
    scheme*: UriTextRangeA   ## ```
                             ##   < Scheme (e.g. "http")
                             ## ```
    userInfo*: UriTextRangeA ## ```
                             ##   < User info (e.g. "user:pass")
                             ## ```
    hostText*: UriTextRangeA ## ```
                             ##   < Host text (set for all hosts, excluding square brackets)
                             ## ```
    hostData*: UriHostDataA  ## ```
                             ##   < Structured host type specific data
                             ## ```
    portText*: UriTextRangeA ## ```
                             ##   < Port (e.g. "80")
                             ## ```
    pathHead*: ptr UriPathSegmentA ## ```
                                   ##   < Head of a linked list of path segments
                                   ## ```
    pathTail*: ptr UriPathSegmentA ## ```
                                   ##   < Tail of the list behind pathHead
                                   ## ```
    query*: UriTextRangeA    ## ```
                             ##   < Query without leading "?"
                             ## ```
    fragment*: UriTextRangeA ## ```
                             ##   < Query without leading "#"
                             ## ```
    absolutePath*: UriBool ## ```
                           ##   < Absolute path flag, distincting "a" and "/a";
                           ##   								always <c>URI_FALSE</c> for URIs with host
                           ## ```
    owner*: UriBool          ## ```
                             ##   < Memory owner flag
                             ## ```
    reserved*: pointer       ## ```
                             ##   < Reserved to the parser
                             ## ```
  
  UriUriA* {.importc, impUriHdr.} = UriUriStructA ## ```
                                                  ##   < @copydoc UriHostDataStructA 
                                                  ##     
                                                  ##    Represents an RFC 3986 %URI.
                                                  ##    Missing components can be {NULL, NULL} ranges.
                                                  ##   
                                                  ##    @see uriFreeUriMembersA
                                                  ##    @see uriFreeUriMembersMmA
                                                  ##    @see UriParserStateA
                                                  ##    @since 0.3.0
                                                  ## ```
  UriParserStateStructA* {.bycopy, impUriHdr,
                           importc: "struct UriParserStateStructA".} = object ## ```
                                                                               ##   < @copydoc UriUriStructA 
                                                                               ##     
                                                                               ##    Represents a state of the %URI parser.
                                                                               ##    Missing components can be NULL to reflect
                                                                               ##    a components absence.
                                                                               ##   
                                                                               ##    @see uriFreeUriMembersA
                                                                               ##    @see uriFreeUriMembersMmA
                                                                               ##    @since 0.3.0
                                                                               ## ```
    uri*: ptr UriUriA ## ```
                      ##   < Plug in the %URI structure to be filled while parsing here
                      ## ```
    errorCode*: cint         ## ```
                             ##   < Code identifying the error which occurred
                             ## ```
    errorPos*: cstring       ## ```
                             ##   < Pointer to position in case of a syntax error
                             ## ```
    reserved*: pointer       ## ```
                             ##   < Reserved to the parser
                             ## ```
  
  UriParserStateA* {.importc, impUriHdr.} = UriParserStateStructA ## ```
                                                                  ##   < @copydoc UriUriStructA 
                                                                  ##     
                                                                  ##    Represents a state of the %URI parser.
                                                                  ##    Missing components can be NULL to reflect
                                                                  ##    a components absence.
                                                                  ##   
                                                                  ##    @see uriFreeUriMembersA
                                                                  ##    @see uriFreeUriMembersMmA
                                                                  ##    @since 0.3.0
                                                                  ## ```
  UriQueryListStructA* {.bycopy, impUriHdr,
                         importc: "struct UriQueryListStructA".} = object ## ```
                                                                           ##   < @copydoc UriParserStateStructA 
                                                                           ##     
                                                                           ##    Represents a query element.
                                                                           ##    More precisely it is a node in a linked
                                                                           ##    list of query elements.
                                                                           ##   
                                                                           ##    @since 0.7.0
                                                                           ## ```
    key*: cstring            ## ```
                             ##   < Key of the query element
                             ## ```
    value*: cstring          ## ```
                             ##   < Value of the query element, can be NULL
                             ## ```
    next*: ptr UriQueryListStructA ## ```
                                   ##   < Pointer to the next key/value pair in the list, can be NULL if last already
                                   ## ```
  
  UriQueryListA* {.importc, impUriHdr.} = UriQueryListStructA ## ```
                                                              ##   < @copydoc UriParserStateStructA 
                                                              ##     
                                                              ##    Represents a query element.
                                                              ##    More precisely it is a node in a linked
                                                              ##    list of query elements.
                                                              ##   
                                                              ##    @since 0.7.0
                                                              ## ```
  UriTextRangeStructW* {.bycopy, impUriHdr,
                         importc: "struct UriTextRangeStructW".} = object ## ```
                                                                           ##   uriparser - RFC 3986 URI parsing library
                                                                           ##   
                                                                           ##    Copyright (C) 2007, Weijia Song <songweijia@gmail.com>
                                                                           ##    Copyright (C) 2007, Sebastian Pipping <sebastian@pipping.org>
                                                                           ##    All rights reserved.
                                                                           ##   
                                                                           ##    Redistribution and use in source  and binary forms, with or without
                                                                           ##    modification, are permitted provided  that the following conditions
                                                                           ##    are met:
                                                                           ##   
                                                                           ##        1. Redistributions  of  source  code   must  retain  the  above
                                                                           ##           copyright notice, this list  of conditions and the following
                                                                           ##           disclaimer.
                                                                           ##   
                                                                           ##        2. Redistributions  in binary  form  must  reproduce the  above
                                                                           ##           copyright notice, this list  of conditions and the following
                                                                           ##           disclaimer  in  the  documentation  and/or  other  materials
                                                                           ##           provided with the distribution.
                                                                           ##   
                                                                           ##        3. Neither the  name of the  copyright holder nor the  names of
                                                                           ##           its contributors may be used  to endorse or promote products
                                                                           ##           derived from  this software  without specific  prior written
                                                                           ##           permission.
                                                                           ##   
                                                                           ##    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
                                                                           ##    "AS IS" AND  ANY EXPRESS OR IMPLIED WARRANTIES,  INCLUDING, BUT NOT
                                                                           ##    LIMITED TO,  THE IMPLIED WARRANTIES OF  MERCHANTABILITY AND FITNESS
                                                                           ##    FOR  A  PARTICULAR  PURPOSE  ARE  DISCLAIMED.  IN  NO  EVENT  SHALL
                                                                           ##    THE  COPYRIGHT HOLDER  OR CONTRIBUTORS  BE LIABLE  FOR ANY  DIRECT,
                                                                           ##    INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES
                                                                           ##    (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR
                                                                           ##    SERVICES; LOSS OF USE, DATA,  OR PROFITS; OR BUSINESS INTERRUPTION)
                                                                           ##    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
                                                                           ##    STRICT  LIABILITY,  OR  TORT (INCLUDING  NEGLIGENCE  OR  OTHERWISE)
                                                                           ##    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
                                                                           ##    OF THE POSSIBILITY OF SUCH DAMAGE.
                                                                           ##    
                                                                           ##     
                                                                           ##    @file UriBase.h
                                                                           ##    Holds definitions independent of the encoding pass.
                                                                           ##    
                                                                           ##     
                                                                           ##    Specifies a range of characters within a string.
                                                                           ##    The range includes all characters from <c>first</c>
                                                                           ##    to one before <c>afterLast</c>. So if both are
                                                                           ##    non-NULL the difference is the length of the text range.
                                                                           ##   
                                                                           ##    @see UriUriA
                                                                           ##    @see UriPathSegmentA
                                                                           ##    @see UriHostDataA
                                                                           ##    @since 0.3.0
                                                                           ## ```
    first*: ptr wchar_t      ## ```
                             ##   < Pointer to first character
                             ## ```
    afterLast*: ptr wchar_t ## ```
                            ##   < Pointer to character after the last one still in
                            ## ```
  
  UriTextRangeW* {.importc, impUriHdr.} = UriTextRangeStructW ## ```
                                                              ##   uriparser - RFC 3986 URI parsing library
                                                              ##   
                                                              ##    Copyright (C) 2007, Weijia Song <songweijia@gmail.com>
                                                              ##    Copyright (C) 2007, Sebastian Pipping <sebastian@pipping.org>
                                                              ##    All rights reserved.
                                                              ##   
                                                              ##    Redistribution and use in source  and binary forms, with or without
                                                              ##    modification, are permitted provided  that the following conditions
                                                              ##    are met:
                                                              ##   
                                                              ##        1. Redistributions  of  source  code   must  retain  the  above
                                                              ##           copyright notice, this list  of conditions and the following
                                                              ##           disclaimer.
                                                              ##   
                                                              ##        2. Redistributions  in binary  form  must  reproduce the  above
                                                              ##           copyright notice, this list  of conditions and the following
                                                              ##           disclaimer  in  the  documentation  and/or  other  materials
                                                              ##           provided with the distribution.
                                                              ##   
                                                              ##        3. Neither the  name of the  copyright holder nor the  names of
                                                              ##           its contributors may be used  to endorse or promote products
                                                              ##           derived from  this software  without specific  prior written
                                                              ##           permission.
                                                              ##   
                                                              ##    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
                                                              ##    "AS IS" AND  ANY EXPRESS OR IMPLIED WARRANTIES,  INCLUDING, BUT NOT
                                                              ##    LIMITED TO,  THE IMPLIED WARRANTIES OF  MERCHANTABILITY AND FITNESS
                                                              ##    FOR  A  PARTICULAR  PURPOSE  ARE  DISCLAIMED.  IN  NO  EVENT  SHALL
                                                              ##    THE  COPYRIGHT HOLDER  OR CONTRIBUTORS  BE LIABLE  FOR ANY  DIRECT,
                                                              ##    INDIRECT, INCIDENTAL, SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES
                                                              ##    (INCLUDING, BUT NOT LIMITED TO,  PROCUREMENT OF SUBSTITUTE GOODS OR
                                                              ##    SERVICES; LOSS OF USE, DATA,  OR PROFITS; OR BUSINESS INTERRUPTION)
                                                              ##    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
                                                              ##    STRICT  LIABILITY,  OR  TORT (INCLUDING  NEGLIGENCE  OR  OTHERWISE)
                                                              ##    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
                                                              ##    OF THE POSSIBILITY OF SUCH DAMAGE.
                                                              ##    
                                                              ##     
                                                              ##    @file UriBase.h
                                                              ##    Holds definitions independent of the encoding pass.
                                                              ##    
                                                              ##     
                                                              ##    Specifies a range of characters within a string.
                                                              ##    The range includes all characters from <c>first</c>
                                                              ##    to one before <c>afterLast</c>. So if both are
                                                              ##    non-NULL the difference is the length of the text range.
                                                              ##   
                                                              ##    @see UriUriA
                                                              ##    @see UriPathSegmentA
                                                              ##    @see UriHostDataA
                                                              ##    @since 0.3.0
                                                              ## ```
  UriPathSegmentStructW* {.bycopy, impUriHdr,
                           importc: "struct UriPathSegmentStructW".} = object ## ```
                                                                               ##   < @copydoc UriTextRangeStructA 
                                                                               ##     
                                                                               ##    Represents a path segment within a %URI path.
                                                                               ##    More precisely it is a node in a linked
                                                                               ##    list of path segments.
                                                                               ##   
                                                                               ##    @see UriUriA
                                                                               ##    @since 0.3.0
                                                                               ## ```
    text*: UriTextRangeW     ## ```
                             ##   < Path segment name
                             ## ```
    next*: ptr UriPathSegmentStructW ## ```
                                     ##   < Pointer to the next path segment in the list, can be NULL if last already
                                     ## ```
    reserved*: pointer       ## ```
                             ##   < Reserved to the parser
                             ## ```
  
  UriPathSegmentW* {.importc, impUriHdr.} = UriPathSegmentStructW ## ```
                                                                  ##   < @copydoc UriTextRangeStructA 
                                                                  ##     
                                                                  ##    Represents a path segment within a %URI path.
                                                                  ##    More precisely it is a node in a linked
                                                                  ##    list of path segments.
                                                                  ##   
                                                                  ##    @see UriUriA
                                                                  ##    @since 0.3.0
                                                                  ## ```
  UriHostDataStructW* {.bycopy, impUriHdr, importc: "struct UriHostDataStructW".} = object ## ```
                                                                                            ##   < @copydoc UriPathSegmentStructA 
                                                                                            ##     
                                                                                            ##    Holds structured host information.
                                                                                            ##    This is either a IPv4, IPv6, plain
                                                                                            ##    text for IPvFuture or all zero for
                                                                                            ##    a registered name.
                                                                                            ##   
                                                                                            ##    @see UriUriA
                                                                                            ##    @since 0.3.0
                                                                                            ## ```
    ip4*: ptr UriIp4         ## ```
                             ##   < IPv4 address
                             ## ```
    ip6*: ptr UriIp6         ## ```
                             ##   < IPv6 address
                             ## ```
    ipFuture*: UriTextRangeW ## ```
                             ##   < IPvFuture address
                             ## ```
  
  UriHostDataW* {.importc, impUriHdr.} = UriHostDataStructW ## ```
                                                            ##   < @copydoc UriPathSegmentStructA 
                                                            ##     
                                                            ##    Holds structured host information.
                                                            ##    This is either a IPv4, IPv6, plain
                                                            ##    text for IPvFuture or all zero for
                                                            ##    a registered name.
                                                            ##   
                                                            ##    @see UriUriA
                                                            ##    @since 0.3.0
                                                            ## ```
  UriUriStructW* {.bycopy, impUriHdr, importc: "struct UriUriStructW".} = object ## ```
                                                                                  ##   < @copydoc UriHostDataStructA 
                                                                                  ##     
                                                                                  ##    Represents an RFC 3986 %URI.
                                                                                  ##    Missing components can be {NULL, NULL} ranges.
                                                                                  ##   
                                                                                  ##    @see uriFreeUriMembersA
                                                                                  ##    @see uriFreeUriMembersMmA
                                                                                  ##    @see UriParserStateA
                                                                                  ##    @since 0.3.0
                                                                                  ## ```
    scheme*: UriTextRangeW   ## ```
                             ##   < Scheme (e.g. "http")
                             ## ```
    userInfo*: UriTextRangeW ## ```
                             ##   < User info (e.g. "user:pass")
                             ## ```
    hostText*: UriTextRangeW ## ```
                             ##   < Host text (set for all hosts, excluding square brackets)
                             ## ```
    hostData*: UriHostDataW  ## ```
                             ##   < Structured host type specific data
                             ## ```
    portText*: UriTextRangeW ## ```
                             ##   < Port (e.g. "80")
                             ## ```
    pathHead*: ptr UriPathSegmentW ## ```
                                   ##   < Head of a linked list of path segments
                                   ## ```
    pathTail*: ptr UriPathSegmentW ## ```
                                   ##   < Tail of the list behind pathHead
                                   ## ```
    query*: UriTextRangeW    ## ```
                             ##   < Query without leading "?"
                             ## ```
    fragment*: UriTextRangeW ## ```
                             ##   < Query without leading "#"
                             ## ```
    absolutePath*: UriBool ## ```
                           ##   < Absolute path flag, distincting "a" and "/a";
                           ##   								always <c>URI_FALSE</c> for URIs with host
                           ## ```
    owner*: UriBool          ## ```
                             ##   < Memory owner flag
                             ## ```
    reserved*: pointer       ## ```
                             ##   < Reserved to the parser
                             ## ```
  
  UriUriW* {.importc, impUriHdr.} = UriUriStructW ## ```
                                                  ##   < @copydoc UriHostDataStructA 
                                                  ##     
                                                  ##    Represents an RFC 3986 %URI.
                                                  ##    Missing components can be {NULL, NULL} ranges.
                                                  ##   
                                                  ##    @see uriFreeUriMembersA
                                                  ##    @see uriFreeUriMembersMmA
                                                  ##    @see UriParserStateA
                                                  ##    @since 0.3.0
                                                  ## ```
  UriParserStateStructW* {.bycopy, impUriHdr,
                           importc: "struct UriParserStateStructW".} = object ## ```
                                                                               ##   < @copydoc UriUriStructA 
                                                                               ##     
                                                                               ##    Represents a state of the %URI parser.
                                                                               ##    Missing components can be NULL to reflect
                                                                               ##    a components absence.
                                                                               ##   
                                                                               ##    @see uriFreeUriMembersA
                                                                               ##    @see uriFreeUriMembersMmA
                                                                               ##    @since 0.3.0
                                                                               ## ```
    uri*: ptr UriUriW ## ```
                      ##   < Plug in the %URI structure to be filled while parsing here
                      ## ```
    errorCode*: cint         ## ```
                             ##   < Code identifying the error which occurred
                             ## ```
    errorPos*: ptr wchar_t   ## ```
                             ##   < Pointer to position in case of a syntax error
                             ## ```
    reserved*: pointer       ## ```
                             ##   < Reserved to the parser
                             ## ```
  
  UriParserStateW* {.importc, impUriHdr.} = UriParserStateStructW ## ```
                                                                  ##   < @copydoc UriUriStructA 
                                                                  ##     
                                                                  ##    Represents a state of the %URI parser.
                                                                  ##    Missing components can be NULL to reflect
                                                                  ##    a components absence.
                                                                  ##   
                                                                  ##    @see uriFreeUriMembersA
                                                                  ##    @see uriFreeUriMembersMmA
                                                                  ##    @since 0.3.0
                                                                  ## ```
  UriQueryListStructW* {.bycopy, impUriHdr,
                         importc: "struct UriQueryListStructW".} = object ## ```
                                                                           ##   < @copydoc UriParserStateStructA 
                                                                           ##     
                                                                           ##    Represents a query element.
                                                                           ##    More precisely it is a node in a linked
                                                                           ##    list of query elements.
                                                                           ##   
                                                                           ##    @since 0.7.0
                                                                           ## ```
    key*: ptr wchar_t        ## ```
                             ##   < Key of the query element
                             ## ```
    value*: ptr wchar_t      ## ```
                             ##   < Value of the query element, can be NULL
                             ## ```
    next*: ptr UriQueryListStructW ## ```
                                   ##   < Pointer to the next key/value pair in the list, can be NULL if last already
                                   ## ```
  
  UriQueryListW* {.importc, impUriHdr.} = UriQueryListStructW ## ```
                                                              ##   < @copydoc UriParserStateStructA 
                                                              ##     
                                                              ##    Represents a query element.
                                                              ##    More precisely it is a node in a linked
                                                              ##    list of query elements.
                                                              ##   
                                                              ##    @since 0.7.0
                                                              ## ```
proc uriCompleteMemoryManager*(memory: ptr UriMemoryManager;
                               backend: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   < @copydoc UriResolutionOptionsEnum 
                      ##     
                      ##    Wraps a memory manager backend that only provides malloc and free
                      ##    to make a complete memory manager ready to be used.
                      ##   
                      ##    The core feature of this wrapper is that you don't need to implement
                      ##    realloc if you don't want to.  The wrapped memory manager uses
                      ##    backend->malloc, memcpy, and backend->free and soieof(size_t) extra
                      ##    bytes per allocation to emulate fallback realloc for you.
                      ##   
                      ##    memory->calloc is uriEmulateCalloc.
                      ##    memory->free uses backend->free and handles the size header.
                      ##    memory->malloc uses backend->malloc and adds a size header.
                      ##    memory->realloc uses memory->malloc, memcpy, and memory->free and reads
                      ##                    the size header.
                      ##    memory->reallocarray is uriEmulateReallocarray.
                      ##   
                      ##    The internal workings behind memory->free, memory->malloc, and
                      ##    memory->realloc may change so the functions exposed by these function
                      ##    pointer sshould be consided internal and not public API.
                      ##   
                      ##    @param memory   <b>OUT</b>: Where to write the wrapped memory manager to
                      ##    @param backend  <b>IN</b>: Memory manager to use as a backend
                      ##    @return          Error code or 0 on success
                      ##   
                      ##    @see uriEmulateCalloc
                      ##    @see uriEmulateReallocarray
                      ##    @see UriMemoryManager
                      ##    @since 0.9.0
                      ## ```
proc uriEmulateCalloc*(memory: ptr UriMemoryManager; nmemb: uint; size: uint): pointer {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Offers emulation of calloc(3) based on memory->malloc and memset.
                               ##    See "man 3 calloc" as well.
                               ##   
                               ##    @param memory  <b>IN</b>: Memory manager to use, should not be NULL
                               ##    @param nmemb   <b>IN</b>: Number of elements to allocate
                               ##    @param size    <b>IN</b>: Size in bytes per element
                               ##    @return        Pointer to allocated memory or NULL
                               ##   
                               ##    @see uriCompleteMemoryManager
                               ##    @see uriEmulateReallocarray
                               ##    @see UriMemoryManager
                               ##    @since 0.9.0
                               ## ```
proc uriEmulateReallocarray*(memory: ptr UriMemoryManager; `ptr`: pointer;
                             nmemb: uint; size: uint): pointer {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Offers emulation of reallocarray(3) based on memory->realloc.
               ##    See "man 3 reallocarray" as well.
               ##   
               ##    @param memory  <b>IN</b>: Memory manager to use, should not be NULL
               ##    @param ptr     <b>IN</b>: Pointer allocated using memory->malloc/... or NULL
               ##    @param nmemb   <b>IN</b>: Number of elements to allocate
               ##    @param size    <b>IN</b>: Size in bytes per element
               ##    @return        Pointer to allocated memory or NULL
               ##   
               ##    @see uriCompleteMemoryManager
               ##    @see uriEmulateCalloc
               ##    @see UriMemoryManager
               ##    @since 0.9.0
               ## ```
proc uriTestMemoryManager*(memory: ptr UriMemoryManager): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Run multiple tests against a given memory manager.
               ##    For example, one test
               ##    1. allocates a small amount of memory,
               ##    2. writes some magic bytes to it,
               ##    3. reallocates it,
               ##    4. checks that previous values are still present,
               ##    5. and frees that memory.
               ##   
               ##    It is recommended to compile with AddressSanitizer enabled
               ##    to take full advantage of uriTestMemoryManager.
               ##   
               ##    @param memory  <b>IN</b>: Memory manager to use, should not be NULL
               ##    @return        Error code or 0 on success
               ##   
               ##    @see uriEmulateCalloc
               ##    @see uriEmulateReallocarray
               ##    @see UriMemoryManager
               ##    @since 0.9.0
               ## ```
proc uriParseUriExA*(state: ptr UriParserStateA; first: cstring;
                     afterLast: cstring): cint {.importc, cdecl, impUriHdr.}
  ## ```
                                                                            ##   < @copydoc UriQueryListStructA 
                                                                            ##     
                                                                            ##    Parses a RFC 3986 %URI.
                                                                            ##    Uses default libc-based memory manager.
                                                                            ##   
                                                                            ##    @param state       <b>INOUT</b>: Parser state with set output %URI, must not be NULL
                                                                            ##    @param first       <b>IN</b>: Pointer to the first character to parse, must not be NULL
                                                                            ##    @param afterLast   <b>IN</b>: Pointer to the character after the last to parse, must not be NULL
                                                                            ##    @return            0 on success, error code otherwise
                                                                            ##   
                                                                            ##    @see uriParseUriA
                                                                            ##    @see uriParseSingleUriA
                                                                            ##    @see uriParseSingleUriExA
                                                                            ##    @see uriToStringA
                                                                            ##    @since 0.3.0
                                                                            ##    @deprecated Deprecated since 0.9.0, please migrate to uriParseSingleUriExA (with "Single").
                                                                            ## ```
proc uriParseUriA*(state: ptr UriParserStateA; text: cstring): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Parses a RFC 3986 %URI.
                      ##    Uses default libc-based memory manager.
                      ##   
                      ##    @param state   <b>INOUT</b>: Parser state with set output %URI, must not be NULL
                      ##    @param text    <b>IN</b>: Text to parse, must not be NULL
                      ##    @return        0 on success, error code otherwise
                      ##   
                      ##    @see uriParseUriExA
                      ##    @see uriParseSingleUriA
                      ##    @see uriParseSingleUriExA
                      ##    @see uriToStringA
                      ##    @since 0.3.0
                      ##    @deprecated Deprecated since 0.9.0, please migrate to uriParseSingleUriA (with "Single").
                      ## ```
proc uriParseSingleUriA*(uri: ptr UriUriA; text: cstring; errorPos: ptr cstring): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Parses a single RFC 3986 %URI.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param uri         <b>OUT</b>: Output %URI, must not be NULL
                               ##    @param text        <b>IN</b>: Pointer to the first character to parse,
                               ##                                  must not be NULL
                               ##    @param errorPos    <b>OUT</b>: Pointer to a pointer to the first character
                               ##                                   causing a syntax error, can be NULL;
                               ##                                   only set when URI_ERROR_SYNTAX was returned
                               ##    @return            0 on success, error code otherwise
                               ##   
                               ##    @see uriParseSingleUriExA
                               ##    @see uriParseSingleUriExMmA
                               ##    @see uriToStringA
                               ##    @since 0.9.0
                               ## ```
proc uriParseSingleUriExA*(uri: ptr UriUriA; first: cstring; afterLast: cstring;
                           errorPos: ptr cstring): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Parses a single RFC 3986 %URI.
               ##    Uses default libc-based memory manager.
               ##   
               ##    @param uri         <b>OUT</b>: Output %URI, must not be NULL
               ##    @param first       <b>IN</b>: Pointer to the first character to parse,
               ##                                  must not be NULL
               ##    @param afterLast   <b>IN</b>: Pointer to the character after the last to
               ##                                  parse, can be NULL
               ##                                  (to use first + strlen(first))
               ##    @param errorPos    <b>OUT</b>: Pointer to a pointer to the first character
               ##                                   causing a syntax error, can be NULL;
               ##                                   only set when URI_ERROR_SYNTAX was returned
               ##    @return            0 on success, error code otherwise
               ##   
               ##    @see uriParseSingleUriA
               ##    @see uriParseSingleUriExMmA
               ##    @see uriToStringA
               ##    @since 0.9.0
               ## ```
proc uriParseSingleUriExMmA*(uri: ptr UriUriA; first: cstring;
                             afterLast: cstring; errorPos: ptr cstring;
                             memory: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Parses a single RFC 3986 %URI.
                      ##   
                      ##    @param uri         <b>OUT</b>: Output %URI, must not be NULL
                      ##    @param first       <b>IN</b>: Pointer to the first character to parse,
                      ##                                  must not be NULL
                      ##    @param afterLast   <b>IN</b>: Pointer to the character after the last to
                      ##                                  parse, can be NULL
                      ##                                  (to use first + strlen(first))
                      ##    @param errorPos    <b>OUT</b>: Pointer to a pointer to the first character
                      ##                                   causing a syntax error, can be NULL;
                      ##                                   only set when URI_ERROR_SYNTAX was returned
                      ##    @param memory      <b>IN</b>: Memory manager to use, NULL for default libc
                      ##    @return            0 on success, error code otherwise
                      ##   
                      ##    @see uriParseSingleUriA
                      ##    @see uriParseSingleUriExA
                      ##    @see uriToStringA
                      ##    @since 0.9.0
                      ## ```
proc uriFreeUriMembersA*(uri: ptr UriUriA) {.importc, cdecl, impUriHdr.}
  ## ```
                                                                        ##   Frees all memory associated with the members
                                                                        ##    of the %URI structure. Note that the structure
                                                                        ##    itself is not freed, only its members.
                                                                        ##    Uses default libc-based memory manager.
                                                                        ##   
                                                                        ##    @param uri   <b>INOUT</b>: %URI structure whose members should be freed
                                                                        ##   
                                                                        ##    @see uriFreeUriMembersMmA
                                                                        ##    @since 0.3.0
                                                                        ## ```
proc uriFreeUriMembersMmA*(uri: ptr UriUriA; memory: ptr UriMemoryManager): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Frees all memory associated with the members
                               ##    of the %URI structure. Note that the structure
                               ##    itself is not freed, only its members.
                               ##   
                               ##    @param uri     <b>INOUT</b>: %URI structure whose members should be freed
                               ##    @param memory  <b>IN</b>: Memory manager to use, NULL for default libc
                               ##    @return        0 on success, error code otherwise
                               ##   
                               ##    @see uriFreeUriMembersA
                               ##    @since 0.9.0
                               ## ```
proc uriEscapeExA*(inFirst: cstring; inAfterLast: cstring; `out`: cstring;
                   spaceToPlus: UriBool; normalizeBreaks: UriBool): cstring {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Percent-encodes all unreserved characters from the input string and
                               ##    writes the encoded version to the output string.
                               ##    Be sure to allocate <b>3 times</b> the space of the input buffer for
                               ##    the output buffer for <c>normalizeBreaks == URI_FALSE</c> and <b>6 times</b>
                               ##    the space for <c>normalizeBreaks == URI_TRUE</c>
                               ##    (since e.g. "\x0d" becomes "%0D%0A" in that case)
                               ##   
                               ##    @param inFirst           <b>IN</b>: Pointer to first character of the input text
                               ##    @param inAfterLast       <b>IN</b>: Pointer after the last character of the input text
                               ##    @param out               <b>OUT</b>: Encoded text destination
                               ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                               ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                               ##    @return                  Position of terminator in output string
                               ##   
                               ##    @see uriEscapeA
                               ##    @see uriUnescapeInPlaceExA
                               ##    @since 0.5.2
                               ## ```
proc uriEscapeA*(`in`: cstring; `out`: cstring; spaceToPlus: UriBool;
                 normalizeBreaks: UriBool): cstring {.importc, cdecl, impUriHdr.}
  ## ```
                                                                                 ##   Percent-encodes all unreserved characters from the input string and
                                                                                 ##    writes the encoded version to the output string.
                                                                                 ##    Be sure to allocate <b>3 times</b> the space of the input buffer for
                                                                                 ##    the output buffer for <c>normalizeBreaks == URI_FALSE</c> and <b>6 times</b>
                                                                                 ##    the space for <c>normalizeBreaks == URI_TRUE</c>
                                                                                 ##    (since e.g. "\x0d" becomes "%0D%0A" in that case)
                                                                                 ##   
                                                                                 ##    @param in                <b>IN</b>: Text source
                                                                                 ##    @param out               <b>OUT</b>: Encoded text destination
                                                                                 ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                                                                                 ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                                                                                 ##    @return                  Position of terminator in output string
                                                                                 ##   
                                                                                 ##    @see uriEscapeExA
                                                                                 ##    @see uriUnescapeInPlaceA
                                                                                 ##    @since 0.5.0
                                                                                 ## ```
proc uriUnescapeInPlaceExA*(inout: cstring; plusToSpace: UriBool;
                            breakConversion: UriBreakConversion): cstring {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Unescapes percent-encoded groups in a given string.
                               ##    E.g. "%20" will become " ". Unescaping is done in place.
                               ##    The return value will be point to the new position
                               ##    of the terminating zero. Use this value to get the new
                               ##    length of the string. NULL is only returned if <c>inout</c>
                               ##    is NULL.
                               ##   
                               ##    @param inout             <b>INOUT</b>: Text to unescape/decode
                               ##    @param plusToSpace       <b>IN</b>: Whether to convert '+' to ' ' or not
                               ##    @param breakConversion   <b>IN</b>: Line break conversion mode
                               ##    @return                  Pointer to new position of the terminating zero
                               ##   
                               ##    @see uriUnescapeInPlaceA
                               ##    @see uriEscapeExA
                               ##    @since 0.5.0
                               ## ```
proc uriUnescapeInPlaceA*(inout: cstring): cstring {.importc, cdecl, impUriHdr.}
  ## ```
                                                                                ##   Unescapes percent-encoded groups in a given string.
                                                                                ##    E.g. "%20" will become " ". Unescaping is done in place.
                                                                                ##    The return value will be point to the new position
                                                                                ##    of the terminating zero. Use this value to get the new
                                                                                ##    length of the string. NULL is only returned if <c>inout</c>
                                                                                ##    is NULL.
                                                                                ##   
                                                                                ##    NOTE: '+' is not decoded to ' ' and line breaks are not converted.
                                                                                ##    Use the more advanced UnescapeInPlaceEx for that features instead.
                                                                                ##   
                                                                                ##    @param inout   <b>INOUT</b>: Text to unescape/decode
                                                                                ##    @return        Pointer to new position of the terminating zero
                                                                                ##   
                                                                                ##    @see uriUnescapeInPlaceExA
                                                                                ##    @see uriEscapeA
                                                                                ##    @since 0.3.0
                                                                                ## ```
proc uriAddBaseUriA*(absoluteDest: ptr UriUriA; relativeSource: ptr UriUriA;
                     absoluteBase: ptr UriUriA): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Performs reference resolution as described in
               ##    <a href="http:tools.ietf.org/html/rfc3986#section-5.2.2">section 5.2.2 of RFC 3986</a>.
               ##    Uses default libc-based memory manager.
               ##    NOTE: On success you have to call uriFreeUriMembersA on \p absoluteDest manually later.
               ##   
               ##    @param absoluteDest     <b>OUT</b>: Result %URI
               ##    @param relativeSource   <b>IN</b>: Reference to resolve
               ##    @param absoluteBase     <b>IN</b>: Base %URI to apply
               ##    @return                 Error code or 0 on success
               ##   
               ##    @see uriRemoveBaseUriA
               ##    @see uriRemoveBaseUriMmA
               ##    @see uriAddBaseUriExA
               ##    @see uriAddBaseUriExMmA
               ##    @since 0.4.0
               ## ```
proc uriAddBaseUriExA*(absoluteDest: ptr UriUriA; relativeSource: ptr UriUriA;
                       absoluteBase: ptr UriUriA; options: UriResolutionOptions): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Performs reference resolution as described in
                               ##    <a href="http:tools.ietf.org/html/rfc3986#section-5.2.2">section 5.2.2 of RFC 3986</a>.
                               ##    Uses default libc-based memory manager.
                               ##    NOTE: On success you have to call uriFreeUriMembersA on \p absoluteDest manually later.
                               ##   
                               ##    @param absoluteDest     <b>OUT</b>: Result %URI
                               ##    @param relativeSource   <b>IN</b>: Reference to resolve
                               ##    @param absoluteBase     <b>IN</b>: Base %URI to apply
                               ##    @param options          <b>IN</b>: Configuration to apply
                               ##    @return                 Error code or 0 on success
                               ##   
                               ##    @see uriRemoveBaseUriA
                               ##    @see uriAddBaseUriA
                               ##    @see uriAddBaseUriExMmA
                               ##    @since 0.8.1
                               ## ```
proc uriAddBaseUriExMmA*(absoluteDest: ptr UriUriA; relativeSource: ptr UriUriA;
                         absoluteBase: ptr UriUriA;
                         options: UriResolutionOptions;
                         memory: ptr UriMemoryManager): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Performs reference resolution as described in
               ##    <a href="http:tools.ietf.org/html/rfc3986#section-5.2.2">section 5.2.2 of RFC 3986</a>.
               ##    NOTE: On success you have to call uriFreeUriMembersMmA on \p absoluteDest manually later.
               ##   
               ##    @param absoluteDest     <b>OUT</b>: Result %URI
               ##    @param relativeSource   <b>IN</b>: Reference to resolve
               ##    @param absoluteBase     <b>IN</b>: Base %URI to apply
               ##    @param options          <b>IN</b>: Configuration to apply
               ##    @param memory           <b>IN</b>: Memory manager to use, NULL for default libc
               ##    @return                 Error code or 0 on success
               ##   
               ##    @see uriRemoveBaseUriA
               ##    @see uriRemoveBaseUriMmA
               ##    @see uriAddBaseUriA
               ##    @see uriAddBaseUriExA
               ##    @since 0.9.0
               ## ```
proc uriRemoveBaseUriA*(dest: ptr UriUriA; absoluteSource: ptr UriUriA;
                        absoluteBase: ptr UriUriA; domainRootMode: UriBool): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Tries to make a relative %URI (a reference) from an
                               ##    absolute %URI and a given base %URI. The resulting %URI is going to be
                               ##    relative if the absolute %URI and base %UI share both scheme and authority.
                               ##    If that is not the case, the result will still be
                               ##    an absolute URI (with scheme part if necessary).
                               ##    Uses default libc-based memory manager.
                               ##    NOTE: On success you have to call uriFreeUriMembersA on
                               ##    \p dest manually later.
                               ##   
                               ##    @param dest             <b>OUT</b>: Result %URI
                               ##    @param absoluteSource   <b>IN</b>: Absolute %URI to make relative
                               ##    @param absoluteBase     <b>IN</b>: Base %URI
                               ##    @param domainRootMode   <b>IN</b>: Create %URI with path relative to domain root
                               ##    @return                 Error code or 0 on success
                               ##   
                               ##    @see uriRemoveBaseUriMmA
                               ##    @see uriAddBaseUriA
                               ##    @see uriAddBaseUriExA
                               ##    @see uriAddBaseUriExMmA
                               ##    @since 0.5.2
                               ## ```
proc uriRemoveBaseUriMmA*(dest: ptr UriUriA; absoluteSource: ptr UriUriA;
                          absoluteBase: ptr UriUriA; domainRootMode: UriBool;
                          memory: ptr UriMemoryManager): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Tries to make a relative %URI (a reference) from an
               ##    absolute %URI and a given base %URI. The resulting %URI is going to be
               ##    relative if the absolute %URI and base %UI share both scheme and authority.
               ##    If that is not the case, the result will still be
               ##    an absolute URI (with scheme part if necessary).
               ##    NOTE: On success you have to call uriFreeUriMembersMmA on
               ##    \p dest manually later.
               ##   
               ##    @param dest             <b>OUT</b>: Result %URI
               ##    @param absoluteSource   <b>IN</b>: Absolute %URI to make relative
               ##    @param absoluteBase     <b>IN</b>: Base %URI
               ##    @param domainRootMode   <b>IN</b>: Create %URI with path relative to domain root
               ##    @param memory           <b>IN</b>: Memory manager to use, NULL for default libc
               ##    @return                 Error code or 0 on success
               ##   
               ##    @see uriRemoveBaseUriA
               ##    @see uriAddBaseUriA
               ##    @see uriAddBaseUriExA
               ##    @see uriAddBaseUriExMmA
               ##    @since 0.9.0
               ## ```
proc uriEqualsUriA*(a: ptr UriUriA; b: ptr UriUriA): UriBool {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Checks two URIs for equivalence. Comparison is done
               ##    the naive way, without prior normalization.
               ##    NOTE: Two <c>NULL</c> URIs are equal as well.
               ##   
               ##    @param a   <b>IN</b>: First %URI
               ##    @param b   <b>IN</b>: Second %URI
               ##    @return    <c>URI_TRUE</c> when equal, <c>URI_FAlSE</c> else
               ##   
               ##    @since 0.4.0
               ## ```
proc uriToStringCharsRequiredA*(uri: ptr UriUriA; charsRequired: ptr cint): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Calculates the number of characters needed to store the
                               ##    string representation of the given %URI excluding the
                               ##    terminator.
                               ##   
                               ##    @param uri             <b>IN</b>: %URI to measure
                               ##    @param charsRequired   <b>OUT</b>: Length of the string representation in characters <b>excluding</b> terminator
                               ##    @return                Error code or 0 on success
                               ##   
                               ##    @see uriToStringA
                               ##    @since 0.5.0
                               ## ```
proc uriToStringA*(dest: cstring; uri: ptr UriUriA; maxChars: cint;
                   charsWritten: ptr cint): cint {.importc, cdecl, impUriHdr.}
  ## ```
                                                                              ##   Converts a %URI structure back to text as described in
                                                                              ##    <a href="http:tools.ietf.org/html/rfc3986#section-5.3">section 5.3 of RFC 3986</a>.
                                                                              ##   
                                                                              ##    @param dest           <b>OUT</b>: Output destination
                                                                              ##    @param uri            <b>IN</b>: %URI to convert
                                                                              ##    @param maxChars       <b>IN</b>: Maximum number of characters to copy <b>including</b> terminator
                                                                              ##    @param charsWritten   <b>OUT</b>: Number of characters written, can be lower than maxChars even if the %URI is too long!
                                                                              ##    @return               Error code or 0 on success
                                                                              ##   
                                                                              ##    @see uriToStringCharsRequiredA
                                                                              ##    @since 0.4.0
                                                                              ## ```
proc uriNormalizeSyntaxMaskRequiredA*(uri: ptr UriUriA): cuint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Determines the components of a %URI that are not normalized.
               ##   
               ##    @param uri   <b>IN</b>: %URI to check
               ##    @return      Normalization job mask
               ##   
               ##    @see uriNormalizeSyntaxA
               ##    @see uriNormalizeSyntaxExA
               ##    @see uriNormalizeSyntaxExMmA
               ##    @see uriNormalizeSyntaxMaskRequiredExA
               ##    @since 0.5.0
               ##    @deprecated Deprecated since 0.9.0, please migrate to uriNormalizeSyntaxMaskRequiredExA (with "Ex").
               ## ```
proc uriNormalizeSyntaxMaskRequiredExA*(uri: ptr UriUriA; outMask: ptr cuint): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Determines the components of a %URI that are not normalized.
                               ##   
                               ##    @param uri      <b>IN</b>: %URI to check
                               ##    @param outMask  <b>OUT</b>: Normalization job mask
                               ##    @return         Error code or 0 on success
                               ##   
                               ##    @see uriNormalizeSyntaxA
                               ##    @see uriNormalizeSyntaxExA
                               ##    @see uriNormalizeSyntaxExMmA
                               ##    @see uriNormalizeSyntaxMaskRequiredA
                               ##    @since 0.9.0
                               ## ```
proc uriNormalizeSyntaxExA*(uri: ptr UriUriA; mask: cuint): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Normalizes a %URI using a normalization mask.
                      ##    The normalization mask decides what components are normalized.
                      ##   
                      ##    NOTE: If necessary the %URI becomes owner of all memory
                      ##    behind the text pointed to. Text is duplicated in that case.
                      ##    Uses default libc-based memory manager.
                      ##   
                      ##    @param uri    <b>INOUT</b>: %URI to normalize
                      ##    @param mask   <b>IN</b>: Normalization mask
                      ##    @return       Error code or 0 on success
                      ##   
                      ##    @see uriNormalizeSyntaxA
                      ##    @see uriNormalizeSyntaxExMmA
                      ##    @see uriNormalizeSyntaxMaskRequiredA
                      ##    @since 0.5.0
                      ## ```
proc uriNormalizeSyntaxExMmA*(uri: ptr UriUriA; mask: cuint;
                              memory: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Normalizes a %URI using a normalization mask.
                      ##    The normalization mask decides what components are normalized.
                      ##   
                      ##    NOTE: If necessary the %URI becomes owner of all memory
                      ##    behind the text pointed to. Text is duplicated in that case.
                      ##   
                      ##    @param uri    <b>INOUT</b>: %URI to normalize
                      ##    @param mask   <b>IN</b>: Normalization mask
                      ##    @param memory <b>IN</b>: Memory manager to use, NULL for default libc
                      ##    @return       Error code or 0 on success
                      ##   
                      ##    @see uriNormalizeSyntaxA
                      ##    @see uriNormalizeSyntaxExA
                      ##    @see uriNormalizeSyntaxMaskRequiredA
                      ##    @since 0.9.0
                      ## ```
proc uriNormalizeSyntaxA*(uri: ptr UriUriA): cint {.importc, cdecl, impUriHdr.}
  ## ```
                                                                               ##   Normalizes all components of a %URI.
                                                                               ##   
                                                                               ##    NOTE: If necessary the %URI becomes owner of all memory
                                                                               ##    behind the text pointed to. Text is duplicated in that case.
                                                                               ##    Uses default libc-based memory manager.
                                                                               ##   
                                                                               ##    @param uri   <b>INOUT</b>: %URI to normalize
                                                                               ##    @return      Error code or 0 on success
                                                                               ##   
                                                                               ##    @see uriNormalizeSyntaxExA
                                                                               ##    @see uriNormalizeSyntaxExMmA
                                                                               ##    @see uriNormalizeSyntaxMaskRequiredA
                                                                               ##    @since 0.5.0
                                                                               ## ```
proc uriUnixFilenameToUriStringA*(filename: cstring; uriString: cstring): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a Unix filename to a %URI string.
                               ##    The destination buffer must be large enough to hold 7 + 3 len(filename) + 1
                               ##    characters in case of an absolute filename or 3 len(filename) + 1 in case
                               ##    of a relative filename.
                               ##   
                               ##    EXAMPLE
                               ##      Input:  "/bin/bash"
                               ##      Output: "file:/bin/bash"
                               ##   
                               ##    @param filename     <b>IN</b>: Unix filename to convert
                               ##    @param uriString    <b>OUT</b>: Destination to write %URI string to
                               ##    @return             Error code or 0 on success
                               ##   
                               ##    @see uriUriStringToUnixFilenameA
                               ##    @see uriWindowsFilenameToUriStringA
                               ##    @since 0.5.2
                               ## ```
proc uriWindowsFilenameToUriStringA*(filename: cstring; uriString: cstring): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a Windows filename to a %URI string.
                               ##    The destination buffer must be large enough to hold 8 + 3 len(filename) + 1
                               ##    characters in case of an absolute filename or 3 len(filename) + 1 in case
                               ##    of a relative filename.
                               ##   
                               ##    EXAMPLE
                               ##      Input:  "E:\\Documents and Settings"
                               ##      Output: "file:/E:/Documents%20and%20Settings"
                               ##   
                               ##    @param filename     <b>IN</b>: Windows filename to convert
                               ##    @param uriString    <b>OUT</b>: Destination to write %URI string to
                               ##    @return             Error code or 0 on success
                               ##   
                               ##    @see uriUriStringToWindowsFilenameA
                               ##    @see uriUnixFilenameToUriStringA
                               ##    @since 0.5.2
                               ## ```
proc uriUriStringToUnixFilenameA*(uriString: cstring; filename: cstring): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Extracts a Unix filename from a %URI string.
                               ##    The destination buffer must be large enough to hold len(uriString) + 1 - 7
                               ##    characters in case of an absolute %URI or len(uriString) + 1 in case
                               ##    of a relative %URI.
                               ##   
                               ##    @param uriString    <b>IN</b>: %URI string to convert
                               ##    @param filename     <b>OUT</b>: Destination to write filename to
                               ##    @return             Error code or 0 on success
                               ##   
                               ##    @see uriUnixFilenameToUriStringA
                               ##    @see uriUriStringToWindowsFilenameA
                               ##    @since 0.5.2
                               ## ```
proc uriUriStringToWindowsFilenameA*(uriString: cstring; filename: cstring): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Extracts a Windows filename from a %URI string.
                               ##    The destination buffer must be large enough to hold len(uriString) + 1 - 5
                               ##    characters in case of an absolute %URI or len(uriString) + 1 in case
                               ##    of a relative %URI.
                               ##   
                               ##    @param uriString    <b>IN</b>: %URI string to convert
                               ##    @param filename     <b>OUT</b>: Destination to write filename to
                               ##    @return             Error code or 0 on success
                               ##   
                               ##    @see uriWindowsFilenameToUriStringA
                               ##    @see uriUriStringToUnixFilenameA
                               ##    @since 0.5.2
                               ## ```
proc uriComposeQueryCharsRequiredA*(queryList: ptr UriQueryListA;
                                    charsRequired: ptr cint): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Calculates the number of characters needed to store the
                      ##    string representation of the given query list excluding the
                      ##    terminator. It is assumed that line breaks are will be
                      ##    normalized to "%0D%0A".
                      ##   
                      ##    @param queryList         <b>IN</b>: Query list to measure
                      ##    @param charsRequired     <b>OUT</b>: Length of the string representation in characters <b>excluding</b> terminator
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriComposeQueryCharsRequiredExA
                      ##    @see uriComposeQueryA
                      ##    @since 0.7.0
                      ## ```
proc uriComposeQueryCharsRequiredExA*(queryList: ptr UriQueryListA;
                                      charsRequired: ptr cint;
                                      spaceToPlus: UriBool;
                                      normalizeBreaks: UriBool): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Calculates the number of characters needed to store the
                      ##    string representation of the given query list excluding the
                      ##    terminator.
                      ##   
                      ##    @param queryList         <b>IN</b>: Query list to measure
                      ##    @param charsRequired     <b>OUT</b>: Length of the string representation in characters <b>excluding</b> terminator
                      ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                      ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriComposeQueryCharsRequiredA
                      ##    @see uriComposeQueryExA
                      ##    @since 0.7.0
                      ## ```
proc uriComposeQueryA*(dest: cstring; queryList: ptr UriQueryListA;
                       maxChars: cint; charsWritten: ptr cint): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Converts a query list structure back to a query string.
                      ##    The composed string does not start with '?',
                      ##    on the way ' ' is converted to '+' and line breaks are
                      ##    normalized to "%0D%0A".
                      ##   
                      ##    @param dest              <b>OUT</b>: Output destination
                      ##    @param queryList         <b>IN</b>: Query list to convert
                      ##    @param maxChars          <b>IN</b>: Maximum number of characters to copy <b>including</b> terminator
                      ##    @param charsWritten      <b>OUT</b>: Number of characters written, can be lower than maxChars even if the query list is too long!
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriComposeQueryExA
                      ##    @see uriComposeQueryMallocA
                      ##    @see uriComposeQueryMallocExA
                      ##    @see uriComposeQueryMallocExMmA
                      ##    @see uriComposeQueryCharsRequiredA
                      ##    @see uriDissectQueryMallocA
                      ##    @see uriDissectQueryMallocExA
                      ##    @see uriDissectQueryMallocExMmA
                      ##    @since 0.7.0
                      ## ```
proc uriComposeQueryExA*(dest: cstring; queryList: ptr UriQueryListA;
                         maxChars: cint; charsWritten: ptr cint;
                         spaceToPlus: UriBool; normalizeBreaks: UriBool): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a query list structure back to a query string.
                               ##    The composed string does not start with '?'.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param queryList         <b>IN</b>: Query list to convert
                               ##    @param maxChars          <b>IN</b>: Maximum number of characters to copy <b>including</b> terminator
                               ##    @param charsWritten      <b>OUT</b>: Number of characters written, can be lower than maxChars even if the query list is too long!
                               ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                               ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriComposeQueryA
                               ##    @see uriComposeQueryMallocA
                               ##    @see uriComposeQueryMallocExA
                               ##    @see uriComposeQueryMallocExMmA
                               ##    @see uriComposeQueryCharsRequiredExA
                               ##    @see uriDissectQueryMallocA
                               ##    @see uriDissectQueryMallocExA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @since 0.7.0
                               ## ```
proc uriComposeQueryMallocA*(dest: ptr cstring; queryList: ptr UriQueryListA): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a query list structure back to a query string.
                               ##    Memory for this string is allocated internally.
                               ##    The composed string does not start with '?',
                               ##    on the way ' ' is converted to '+' and line breaks are
                               ##    normalized to "%0D%0A".
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param queryList         <b>IN</b>: Query list to convert
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriComposeQueryMallocExA
                               ##    @see uriComposeQueryMallocExMmA
                               ##    @see uriComposeQueryA
                               ##    @see uriDissectQueryMallocA
                               ##    @see uriDissectQueryMallocExA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @since 0.7.0
                               ## ```
proc uriComposeQueryMallocExA*(dest: ptr cstring; queryList: ptr UriQueryListA;
                               spaceToPlus: UriBool; normalizeBreaks: UriBool): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a query list structure back to a query string.
                               ##    Memory for this string is allocated internally.
                               ##    The composed string does not start with '?'.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param queryList         <b>IN</b>: Query list to convert
                               ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                               ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriComposeQueryMallocA
                               ##    @see uriComposeQueryMallocExMmA
                               ##    @see uriComposeQueryExA
                               ##    @see uriDissectQueryMallocA
                               ##    @see uriDissectQueryMallocExA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @since 0.7.0
                               ## ```
proc uriComposeQueryMallocExMmA*(dest: ptr cstring;
                                 queryList: ptr UriQueryListA;
                                 spaceToPlus: UriBool; normalizeBreaks: UriBool;
                                 memory: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Converts a query list structure back to a query string.
                      ##    Memory for this string is allocated internally.
                      ##    The composed string does not start with '?'.
                      ##   
                      ##    @param dest              <b>OUT</b>: Output destination
                      ##    @param queryList         <b>IN</b>: Query list to convert
                      ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                      ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                      ##    @param memory            <b>IN</b>: Memory manager to use, NULL for default libc
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriComposeQueryMallocA
                      ##    @see uriComposeQueryMallocExA
                      ##    @see uriComposeQueryExA
                      ##    @see uriDissectQueryMallocA
                      ##    @see uriDissectQueryMallocExA
                      ##    @see uriDissectQueryMallocExMmA
                      ##    @since 0.9.0
                      ## ```
proc uriDissectQueryMallocA*(dest: ptr ptr UriQueryListA; itemCount: ptr cint;
                             first: cstring; afterLast: cstring): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Constructs a query list from the raw query string of a given URI.
                               ##    On the way '+' is converted back to ' ', line breaks are not modified.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param itemCount         <b>OUT</b>: Number of items found, can be NULL
                               ##    @param first             <b>IN</b>: Pointer to first character <b>after</b> '?'
                               ##    @param afterLast         <b>IN</b>: Pointer to character after the last one still in
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriDissectQueryMallocExA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @see uriComposeQueryA
                               ##    @see uriFreeQueryListA
                               ##    @see uriFreeQueryListMmA
                               ##    @since 0.7.0
                               ## ```
proc uriDissectQueryMallocExA*(dest: ptr ptr UriQueryListA; itemCount: ptr cint;
                               first: cstring; afterLast: cstring;
                               plusToSpace: UriBool;
                               breakConversion: UriBreakConversion): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Constructs a query list from the raw query string of a given URI.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param itemCount         <b>OUT</b>: Number of items found, can be NULL
                               ##    @param first             <b>IN</b>: Pointer to first character <b>after</b> '?'
                               ##    @param afterLast         <b>IN</b>: Pointer to character after the last one still in
                               ##    @param plusToSpace       <b>IN</b>: Whether to convert '+' to ' ' or not
                               ##    @param breakConversion   <b>IN</b>: Line break conversion mode
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriDissectQueryMallocA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @see uriComposeQueryExA
                               ##    @see uriFreeQueryListA
                               ##    @since 0.7.0
                               ## ```
proc uriDissectQueryMallocExMmA*(dest: ptr ptr UriQueryListA;
                                 itemCount: ptr cint; first: cstring;
                                 afterLast: cstring; plusToSpace: UriBool;
                                 breakConversion: UriBreakConversion;
                                 memory: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Constructs a query list from the raw query string of a given URI.
                      ##   
                      ##    @param dest              <b>OUT</b>: Output destination
                      ##    @param itemCount         <b>OUT</b>: Number of items found, can be NULL
                      ##    @param first             <b>IN</b>: Pointer to first character <b>after</b> '?'
                      ##    @param afterLast         <b>IN</b>: Pointer to character after the last one still in
                      ##    @param plusToSpace       <b>IN</b>: Whether to convert '+' to ' ' or not
                      ##    @param breakConversion   <b>IN</b>: Line break conversion mode
                      ##    @param memory            <b>IN</b>: Memory manager to use, NULL for default libc
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriDissectQueryMallocA
                      ##    @see uriDissectQueryMallocExA
                      ##    @see uriComposeQueryExA
                      ##    @see uriFreeQueryListA
                      ##    @see uriFreeQueryListMmA
                      ##    @since 0.9.0
                      ## ```
proc uriFreeQueryListA*(queryList: ptr UriQueryListA) {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Frees all memory associated with the given query list.
               ##    The structure itself is freed as well.
               ##   
               ##    @param queryList   <b>INOUT</b>: Query list to free
               ##   
               ##    @see uriFreeQueryListMmA
               ##    @since 0.7.0
               ## ```
proc uriFreeQueryListMmA*(queryList: ptr UriQueryListA;
                          memory: ptr UriMemoryManager): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Frees all memory associated with the given query list.
               ##    The structure itself is freed as well.
               ##   
               ##    @param queryList  <b>INOUT</b>: Query list to free
               ##    @param memory     <b>IN</b>: Memory manager to use, NULL for default libc
               ##    @return           Error code or 0 on success
               ##   
               ##    @see uriFreeQueryListA
               ##    @since 0.9.0
               ## ```
proc uriMakeOwnerA*(uri: ptr UriUriA): cint {.importc, cdecl, impUriHdr.}
  ## ```
                                                                         ##   Makes the %URI hold copies of strings so that it no longer depends
                                                                         ##    on the original %URI string.  If the %URI is already owner of copies,
                                                                         ##    this function returns <c>URI_TRUE</c> and does not modify the %URI further.
                                                                         ##   
                                                                         ##    Uses default libc-based memory manager.
                                                                         ##   
                                                                         ##    @param uri    <b>INOUT</b>: %URI to make independent
                                                                         ##    @return       Error code or 0 on success
                                                                         ##   
                                                                         ##    @see uriMakeOwnerMmA
                                                                         ##    @since 0.9.4
                                                                         ## ```
proc uriMakeOwnerMmA*(uri: ptr UriUriA; memory: ptr UriMemoryManager): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Makes the %URI hold copies of strings so that it no longer depends
                               ##    on the original %URI string.  If the %URI is already owner of copies,
                               ##    this function returns <c>URI_TRUE</c> and does not modify the %URI further.
                               ##   
                               ##    @param uri     <b>INOUT</b>: %URI to make independent
                               ##    @param memory  <b>IN</b>: Memory manager to use, NULL for default libc
                               ##    @return        Error code or 0 on success
                               ##   
                               ##    @see uriMakeOwnerA
                               ##    @since 0.9.4
                               ## ```
proc uriParseUriExW*(state: ptr UriParserStateW; first: ptr wchar_t;
                     afterLast: ptr wchar_t): cint {.importc, cdecl, impUriHdr.}
  ## ```
                                                                                ##   < @copydoc UriQueryListStructA 
                                                                                ##     
                                                                                ##    Parses a RFC 3986 %URI.
                                                                                ##    Uses default libc-based memory manager.
                                                                                ##   
                                                                                ##    @param state       <b>INOUT</b>: Parser state with set output %URI, must not be NULL
                                                                                ##    @param first       <b>IN</b>: Pointer to the first character to parse, must not be NULL
                                                                                ##    @param afterLast   <b>IN</b>: Pointer to the character after the last to parse, must not be NULL
                                                                                ##    @return            0 on success, error code otherwise
                                                                                ##   
                                                                                ##    @see uriParseUriA
                                                                                ##    @see uriParseSingleUriA
                                                                                ##    @see uriParseSingleUriExA
                                                                                ##    @see uriToStringA
                                                                                ##    @since 0.3.0
                                                                                ##    @deprecated Deprecated since 0.9.0, please migrate to uriParseSingleUriExA (with "Single").
                                                                                ## ```
proc uriParseUriW*(state: ptr UriParserStateW; text: ptr wchar_t): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Parses a RFC 3986 %URI.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param state   <b>INOUT</b>: Parser state with set output %URI, must not be NULL
                               ##    @param text    <b>IN</b>: Text to parse, must not be NULL
                               ##    @return        0 on success, error code otherwise
                               ##   
                               ##    @see uriParseUriExA
                               ##    @see uriParseSingleUriA
                               ##    @see uriParseSingleUriExA
                               ##    @see uriToStringA
                               ##    @since 0.3.0
                               ##    @deprecated Deprecated since 0.9.0, please migrate to uriParseSingleUriA (with "Single").
                               ## ```
proc uriParseSingleUriW*(uri: ptr UriUriW; text: ptr wchar_t;
                         errorPos: ptr ptr wchar_t): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Parses a single RFC 3986 %URI.
               ##    Uses default libc-based memory manager.
               ##   
               ##    @param uri         <b>OUT</b>: Output %URI, must not be NULL
               ##    @param text        <b>IN</b>: Pointer to the first character to parse,
               ##                                  must not be NULL
               ##    @param errorPos    <b>OUT</b>: Pointer to a pointer to the first character
               ##                                   causing a syntax error, can be NULL;
               ##                                   only set when URI_ERROR_SYNTAX was returned
               ##    @return            0 on success, error code otherwise
               ##   
               ##    @see uriParseSingleUriExA
               ##    @see uriParseSingleUriExMmA
               ##    @see uriToStringA
               ##    @since 0.9.0
               ## ```
proc uriParseSingleUriExW*(uri: ptr UriUriW; first: ptr wchar_t;
                           afterLast: ptr wchar_t; errorPos: ptr ptr wchar_t): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Parses a single RFC 3986 %URI.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param uri         <b>OUT</b>: Output %URI, must not be NULL
                               ##    @param first       <b>IN</b>: Pointer to the first character to parse,
                               ##                                  must not be NULL
                               ##    @param afterLast   <b>IN</b>: Pointer to the character after the last to
                               ##                                  parse, can be NULL
                               ##                                  (to use first + strlen(first))
                               ##    @param errorPos    <b>OUT</b>: Pointer to a pointer to the first character
                               ##                                   causing a syntax error, can be NULL;
                               ##                                   only set when URI_ERROR_SYNTAX was returned
                               ##    @return            0 on success, error code otherwise
                               ##   
                               ##    @see uriParseSingleUriA
                               ##    @see uriParseSingleUriExMmA
                               ##    @see uriToStringA
                               ##    @since 0.9.0
                               ## ```
proc uriParseSingleUriExMmW*(uri: ptr UriUriW; first: ptr wchar_t;
                             afterLast: ptr wchar_t; errorPos: ptr ptr wchar_t;
                             memory: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Parses a single RFC 3986 %URI.
                      ##   
                      ##    @param uri         <b>OUT</b>: Output %URI, must not be NULL
                      ##    @param first       <b>IN</b>: Pointer to the first character to parse,
                      ##                                  must not be NULL
                      ##    @param afterLast   <b>IN</b>: Pointer to the character after the last to
                      ##                                  parse, can be NULL
                      ##                                  (to use first + strlen(first))
                      ##    @param errorPos    <b>OUT</b>: Pointer to a pointer to the first character
                      ##                                   causing a syntax error, can be NULL;
                      ##                                   only set when URI_ERROR_SYNTAX was returned
                      ##    @param memory      <b>IN</b>: Memory manager to use, NULL for default libc
                      ##    @return            0 on success, error code otherwise
                      ##   
                      ##    @see uriParseSingleUriA
                      ##    @see uriParseSingleUriExA
                      ##    @see uriToStringA
                      ##    @since 0.9.0
                      ## ```
proc uriFreeUriMembersW*(uri: ptr UriUriW) {.importc, cdecl, impUriHdr.}
  ## ```
                                                                        ##   Frees all memory associated with the members
                                                                        ##    of the %URI structure. Note that the structure
                                                                        ##    itself is not freed, only its members.
                                                                        ##    Uses default libc-based memory manager.
                                                                        ##   
                                                                        ##    @param uri   <b>INOUT</b>: %URI structure whose members should be freed
                                                                        ##   
                                                                        ##    @see uriFreeUriMembersMmA
                                                                        ##    @since 0.3.0
                                                                        ## ```
proc uriFreeUriMembersMmW*(uri: ptr UriUriW; memory: ptr UriMemoryManager): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Frees all memory associated with the members
                               ##    of the %URI structure. Note that the structure
                               ##    itself is not freed, only its members.
                               ##   
                               ##    @param uri     <b>INOUT</b>: %URI structure whose members should be freed
                               ##    @param memory  <b>IN</b>: Memory manager to use, NULL for default libc
                               ##    @return        0 on success, error code otherwise
                               ##   
                               ##    @see uriFreeUriMembersA
                               ##    @since 0.9.0
                               ## ```
proc uriEscapeExW*(inFirst: ptr wchar_t; inAfterLast: ptr wchar_t;
                   `out`: ptr wchar_t; spaceToPlus: UriBool;
                   normalizeBreaks: UriBool): ptr wchar_t {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Percent-encodes all unreserved characters from the input string and
               ##    writes the encoded version to the output string.
               ##    Be sure to allocate <b>3 times</b> the space of the input buffer for
               ##    the output buffer for <c>normalizeBreaks == URI_FALSE</c> and <b>6 times</b>
               ##    the space for <c>normalizeBreaks == URI_TRUE</c>
               ##    (since e.g. "\x0d" becomes "%0D%0A" in that case)
               ##   
               ##    @param inFirst           <b>IN</b>: Pointer to first character of the input text
               ##    @param inAfterLast       <b>IN</b>: Pointer after the last character of the input text
               ##    @param out               <b>OUT</b>: Encoded text destination
               ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
               ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
               ##    @return                  Position of terminator in output string
               ##   
               ##    @see uriEscapeA
               ##    @see uriUnescapeInPlaceExA
               ##    @since 0.5.2
               ## ```
proc uriEscapeW*(`in`: ptr wchar_t; `out`: ptr wchar_t; spaceToPlus: UriBool;
                 normalizeBreaks: UriBool): ptr wchar_t {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Percent-encodes all unreserved characters from the input string and
               ##    writes the encoded version to the output string.
               ##    Be sure to allocate <b>3 times</b> the space of the input buffer for
               ##    the output buffer for <c>normalizeBreaks == URI_FALSE</c> and <b>6 times</b>
               ##    the space for <c>normalizeBreaks == URI_TRUE</c>
               ##    (since e.g. "\x0d" becomes "%0D%0A" in that case)
               ##   
               ##    @param in                <b>IN</b>: Text source
               ##    @param out               <b>OUT</b>: Encoded text destination
               ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
               ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
               ##    @return                  Position of terminator in output string
               ##   
               ##    @see uriEscapeExA
               ##    @see uriUnescapeInPlaceA
               ##    @since 0.5.0
               ## ```
proc uriUnescapeInPlaceExW*(inout: ptr wchar_t; plusToSpace: UriBool;
                            breakConversion: UriBreakConversion): ptr wchar_t {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Unescapes percent-encoded groups in a given string.
                               ##    E.g. "%20" will become " ". Unescaping is done in place.
                               ##    The return value will be point to the new position
                               ##    of the terminating zero. Use this value to get the new
                               ##    length of the string. NULL is only returned if <c>inout</c>
                               ##    is NULL.
                               ##   
                               ##    @param inout             <b>INOUT</b>: Text to unescape/decode
                               ##    @param plusToSpace       <b>IN</b>: Whether to convert '+' to ' ' or not
                               ##    @param breakConversion   <b>IN</b>: Line break conversion mode
                               ##    @return                  Pointer to new position of the terminating zero
                               ##   
                               ##    @see uriUnescapeInPlaceA
                               ##    @see uriEscapeExA
                               ##    @since 0.5.0
                               ## ```
proc uriUnescapeInPlaceW*(inout: ptr wchar_t): ptr wchar_t {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Unescapes percent-encoded groups in a given string.
               ##    E.g. "%20" will become " ". Unescaping is done in place.
               ##    The return value will be point to the new position
               ##    of the terminating zero. Use this value to get the new
               ##    length of the string. NULL is only returned if <c>inout</c>
               ##    is NULL.
               ##   
               ##    NOTE: '+' is not decoded to ' ' and line breaks are not converted.
               ##    Use the more advanced UnescapeInPlaceEx for that features instead.
               ##   
               ##    @param inout   <b>INOUT</b>: Text to unescape/decode
               ##    @return        Pointer to new position of the terminating zero
               ##   
               ##    @see uriUnescapeInPlaceExA
               ##    @see uriEscapeA
               ##    @since 0.3.0
               ## ```
proc uriAddBaseUriW*(absoluteDest: ptr UriUriW; relativeSource: ptr UriUriW;
                     absoluteBase: ptr UriUriW): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Performs reference resolution as described in
               ##    <a href="http:tools.ietf.org/html/rfc3986#section-5.2.2">section 5.2.2 of RFC 3986</a>.
               ##    Uses default libc-based memory manager.
               ##    NOTE: On success you have to call uriFreeUriMembersA on \p absoluteDest manually later.
               ##   
               ##    @param absoluteDest     <b>OUT</b>: Result %URI
               ##    @param relativeSource   <b>IN</b>: Reference to resolve
               ##    @param absoluteBase     <b>IN</b>: Base %URI to apply
               ##    @return                 Error code or 0 on success
               ##   
               ##    @see uriRemoveBaseUriA
               ##    @see uriRemoveBaseUriMmA
               ##    @see uriAddBaseUriExA
               ##    @see uriAddBaseUriExMmA
               ##    @since 0.4.0
               ## ```
proc uriAddBaseUriExW*(absoluteDest: ptr UriUriW; relativeSource: ptr UriUriW;
                       absoluteBase: ptr UriUriW; options: UriResolutionOptions): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Performs reference resolution as described in
                               ##    <a href="http:tools.ietf.org/html/rfc3986#section-5.2.2">section 5.2.2 of RFC 3986</a>.
                               ##    Uses default libc-based memory manager.
                               ##    NOTE: On success you have to call uriFreeUriMembersA on \p absoluteDest manually later.
                               ##   
                               ##    @param absoluteDest     <b>OUT</b>: Result %URI
                               ##    @param relativeSource   <b>IN</b>: Reference to resolve
                               ##    @param absoluteBase     <b>IN</b>: Base %URI to apply
                               ##    @param options          <b>IN</b>: Configuration to apply
                               ##    @return                 Error code or 0 on success
                               ##   
                               ##    @see uriRemoveBaseUriA
                               ##    @see uriAddBaseUriA
                               ##    @see uriAddBaseUriExMmA
                               ##    @since 0.8.1
                               ## ```
proc uriAddBaseUriExMmW*(absoluteDest: ptr UriUriW; relativeSource: ptr UriUriW;
                         absoluteBase: ptr UriUriW;
                         options: UriResolutionOptions;
                         memory: ptr UriMemoryManager): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Performs reference resolution as described in
               ##    <a href="http:tools.ietf.org/html/rfc3986#section-5.2.2">section 5.2.2 of RFC 3986</a>.
               ##    NOTE: On success you have to call uriFreeUriMembersMmA on \p absoluteDest manually later.
               ##   
               ##    @param absoluteDest     <b>OUT</b>: Result %URI
               ##    @param relativeSource   <b>IN</b>: Reference to resolve
               ##    @param absoluteBase     <b>IN</b>: Base %URI to apply
               ##    @param options          <b>IN</b>: Configuration to apply
               ##    @param memory           <b>IN</b>: Memory manager to use, NULL for default libc
               ##    @return                 Error code or 0 on success
               ##   
               ##    @see uriRemoveBaseUriA
               ##    @see uriRemoveBaseUriMmA
               ##    @see uriAddBaseUriA
               ##    @see uriAddBaseUriExA
               ##    @since 0.9.0
               ## ```
proc uriRemoveBaseUriW*(dest: ptr UriUriW; absoluteSource: ptr UriUriW;
                        absoluteBase: ptr UriUriW; domainRootMode: UriBool): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Tries to make a relative %URI (a reference) from an
                               ##    absolute %URI and a given base %URI. The resulting %URI is going to be
                               ##    relative if the absolute %URI and base %UI share both scheme and authority.
                               ##    If that is not the case, the result will still be
                               ##    an absolute URI (with scheme part if necessary).
                               ##    Uses default libc-based memory manager.
                               ##    NOTE: On success you have to call uriFreeUriMembersA on
                               ##    \p dest manually later.
                               ##   
                               ##    @param dest             <b>OUT</b>: Result %URI
                               ##    @param absoluteSource   <b>IN</b>: Absolute %URI to make relative
                               ##    @param absoluteBase     <b>IN</b>: Base %URI
                               ##    @param domainRootMode   <b>IN</b>: Create %URI with path relative to domain root
                               ##    @return                 Error code or 0 on success
                               ##   
                               ##    @see uriRemoveBaseUriMmA
                               ##    @see uriAddBaseUriA
                               ##    @see uriAddBaseUriExA
                               ##    @see uriAddBaseUriExMmA
                               ##    @since 0.5.2
                               ## ```
proc uriRemoveBaseUriMmW*(dest: ptr UriUriW; absoluteSource: ptr UriUriW;
                          absoluteBase: ptr UriUriW; domainRootMode: UriBool;
                          memory: ptr UriMemoryManager): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Tries to make a relative %URI (a reference) from an
               ##    absolute %URI and a given base %URI. The resulting %URI is going to be
               ##    relative if the absolute %URI and base %UI share both scheme and authority.
               ##    If that is not the case, the result will still be
               ##    an absolute URI (with scheme part if necessary).
               ##    NOTE: On success you have to call uriFreeUriMembersMmA on
               ##    \p dest manually later.
               ##   
               ##    @param dest             <b>OUT</b>: Result %URI
               ##    @param absoluteSource   <b>IN</b>: Absolute %URI to make relative
               ##    @param absoluteBase     <b>IN</b>: Base %URI
               ##    @param domainRootMode   <b>IN</b>: Create %URI with path relative to domain root
               ##    @param memory           <b>IN</b>: Memory manager to use, NULL for default libc
               ##    @return                 Error code or 0 on success
               ##   
               ##    @see uriRemoveBaseUriA
               ##    @see uriAddBaseUriA
               ##    @see uriAddBaseUriExA
               ##    @see uriAddBaseUriExMmA
               ##    @since 0.9.0
               ## ```
proc uriEqualsUriW*(a: ptr UriUriW; b: ptr UriUriW): UriBool {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Checks two URIs for equivalence. Comparison is done
               ##    the naive way, without prior normalization.
               ##    NOTE: Two <c>NULL</c> URIs are equal as well.
               ##   
               ##    @param a   <b>IN</b>: First %URI
               ##    @param b   <b>IN</b>: Second %URI
               ##    @return    <c>URI_TRUE</c> when equal, <c>URI_FAlSE</c> else
               ##   
               ##    @since 0.4.0
               ## ```
proc uriToStringCharsRequiredW*(uri: ptr UriUriW; charsRequired: ptr cint): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Calculates the number of characters needed to store the
                               ##    string representation of the given %URI excluding the
                               ##    terminator.
                               ##   
                               ##    @param uri             <b>IN</b>: %URI to measure
                               ##    @param charsRequired   <b>OUT</b>: Length of the string representation in characters <b>excluding</b> terminator
                               ##    @return                Error code or 0 on success
                               ##   
                               ##    @see uriToStringA
                               ##    @since 0.5.0
                               ## ```
proc uriToStringW*(dest: ptr wchar_t; uri: ptr UriUriW; maxChars: cint;
                   charsWritten: ptr cint): cint {.importc, cdecl, impUriHdr.}
  ## ```
                                                                              ##   Converts a %URI structure back to text as described in
                                                                              ##    <a href="http:tools.ietf.org/html/rfc3986#section-5.3">section 5.3 of RFC 3986</a>.
                                                                              ##   
                                                                              ##    @param dest           <b>OUT</b>: Output destination
                                                                              ##    @param uri            <b>IN</b>: %URI to convert
                                                                              ##    @param maxChars       <b>IN</b>: Maximum number of characters to copy <b>including</b> terminator
                                                                              ##    @param charsWritten   <b>OUT</b>: Number of characters written, can be lower than maxChars even if the %URI is too long!
                                                                              ##    @return               Error code or 0 on success
                                                                              ##   
                                                                              ##    @see uriToStringCharsRequiredA
                                                                              ##    @since 0.4.0
                                                                              ## ```
proc uriNormalizeSyntaxMaskRequiredW*(uri: ptr UriUriW): cuint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Determines the components of a %URI that are not normalized.
               ##   
               ##    @param uri   <b>IN</b>: %URI to check
               ##    @return      Normalization job mask
               ##   
               ##    @see uriNormalizeSyntaxA
               ##    @see uriNormalizeSyntaxExA
               ##    @see uriNormalizeSyntaxExMmA
               ##    @see uriNormalizeSyntaxMaskRequiredExA
               ##    @since 0.5.0
               ##    @deprecated Deprecated since 0.9.0, please migrate to uriNormalizeSyntaxMaskRequiredExA (with "Ex").
               ## ```
proc uriNormalizeSyntaxMaskRequiredExW*(uri: ptr UriUriW; outMask: ptr cuint): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Determines the components of a %URI that are not normalized.
                               ##   
                               ##    @param uri      <b>IN</b>: %URI to check
                               ##    @param outMask  <b>OUT</b>: Normalization job mask
                               ##    @return         Error code or 0 on success
                               ##   
                               ##    @see uriNormalizeSyntaxA
                               ##    @see uriNormalizeSyntaxExA
                               ##    @see uriNormalizeSyntaxExMmA
                               ##    @see uriNormalizeSyntaxMaskRequiredA
                               ##    @since 0.9.0
                               ## ```
proc uriNormalizeSyntaxExW*(uri: ptr UriUriW; mask: cuint): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Normalizes a %URI using a normalization mask.
                      ##    The normalization mask decides what components are normalized.
                      ##   
                      ##    NOTE: If necessary the %URI becomes owner of all memory
                      ##    behind the text pointed to. Text is duplicated in that case.
                      ##    Uses default libc-based memory manager.
                      ##   
                      ##    @param uri    <b>INOUT</b>: %URI to normalize
                      ##    @param mask   <b>IN</b>: Normalization mask
                      ##    @return       Error code or 0 on success
                      ##   
                      ##    @see uriNormalizeSyntaxA
                      ##    @see uriNormalizeSyntaxExMmA
                      ##    @see uriNormalizeSyntaxMaskRequiredA
                      ##    @since 0.5.0
                      ## ```
proc uriNormalizeSyntaxExMmW*(uri: ptr UriUriW; mask: cuint;
                              memory: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Normalizes a %URI using a normalization mask.
                      ##    The normalization mask decides what components are normalized.
                      ##   
                      ##    NOTE: If necessary the %URI becomes owner of all memory
                      ##    behind the text pointed to. Text is duplicated in that case.
                      ##   
                      ##    @param uri    <b>INOUT</b>: %URI to normalize
                      ##    @param mask   <b>IN</b>: Normalization mask
                      ##    @param memory <b>IN</b>: Memory manager to use, NULL for default libc
                      ##    @return       Error code or 0 on success
                      ##   
                      ##    @see uriNormalizeSyntaxA
                      ##    @see uriNormalizeSyntaxExA
                      ##    @see uriNormalizeSyntaxMaskRequiredA
                      ##    @since 0.9.0
                      ## ```
proc uriNormalizeSyntaxW*(uri: ptr UriUriW): cint {.importc, cdecl, impUriHdr.}
  ## ```
                                                                               ##   Normalizes all components of a %URI.
                                                                               ##   
                                                                               ##    NOTE: If necessary the %URI becomes owner of all memory
                                                                               ##    behind the text pointed to. Text is duplicated in that case.
                                                                               ##    Uses default libc-based memory manager.
                                                                               ##   
                                                                               ##    @param uri   <b>INOUT</b>: %URI to normalize
                                                                               ##    @return      Error code or 0 on success
                                                                               ##   
                                                                               ##    @see uriNormalizeSyntaxExA
                                                                               ##    @see uriNormalizeSyntaxExMmA
                                                                               ##    @see uriNormalizeSyntaxMaskRequiredA
                                                                               ##    @since 0.5.0
                                                                               ## ```
proc uriUnixFilenameToUriStringW*(filename: ptr wchar_t; uriString: ptr wchar_t): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a Unix filename to a %URI string.
                               ##    The destination buffer must be large enough to hold 7 + 3 len(filename) + 1
                               ##    characters in case of an absolute filename or 3 len(filename) + 1 in case
                               ##    of a relative filename.
                               ##   
                               ##    EXAMPLE
                               ##      Input:  "/bin/bash"
                               ##      Output: "file:/bin/bash"
                               ##   
                               ##    @param filename     <b>IN</b>: Unix filename to convert
                               ##    @param uriString    <b>OUT</b>: Destination to write %URI string to
                               ##    @return             Error code or 0 on success
                               ##   
                               ##    @see uriUriStringToUnixFilenameA
                               ##    @see uriWindowsFilenameToUriStringA
                               ##    @since 0.5.2
                               ## ```
proc uriWindowsFilenameToUriStringW*(filename: ptr wchar_t;
                                     uriString: ptr wchar_t): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Converts a Windows filename to a %URI string.
                      ##    The destination buffer must be large enough to hold 8 + 3 len(filename) + 1
                      ##    characters in case of an absolute filename or 3 len(filename) + 1 in case
                      ##    of a relative filename.
                      ##   
                      ##    EXAMPLE
                      ##      Input:  "E:\\Documents and Settings"
                      ##      Output: "file:/E:/Documents%20and%20Settings"
                      ##   
                      ##    @param filename     <b>IN</b>: Windows filename to convert
                      ##    @param uriString    <b>OUT</b>: Destination to write %URI string to
                      ##    @return             Error code or 0 on success
                      ##   
                      ##    @see uriUriStringToWindowsFilenameA
                      ##    @see uriUnixFilenameToUriStringA
                      ##    @since 0.5.2
                      ## ```
proc uriUriStringToUnixFilenameW*(uriString: ptr wchar_t; filename: ptr wchar_t): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Extracts a Unix filename from a %URI string.
                               ##    The destination buffer must be large enough to hold len(uriString) + 1 - 7
                               ##    characters in case of an absolute %URI or len(uriString) + 1 in case
                               ##    of a relative %URI.
                               ##   
                               ##    @param uriString    <b>IN</b>: %URI string to convert
                               ##    @param filename     <b>OUT</b>: Destination to write filename to
                               ##    @return             Error code or 0 on success
                               ##   
                               ##    @see uriUnixFilenameToUriStringA
                               ##    @see uriUriStringToWindowsFilenameA
                               ##    @since 0.5.2
                               ## ```
proc uriUriStringToWindowsFilenameW*(uriString: ptr wchar_t;
                                     filename: ptr wchar_t): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Extracts a Windows filename from a %URI string.
                      ##    The destination buffer must be large enough to hold len(uriString) + 1 - 5
                      ##    characters in case of an absolute %URI or len(uriString) + 1 in case
                      ##    of a relative %URI.
                      ##   
                      ##    @param uriString    <b>IN</b>: %URI string to convert
                      ##    @param filename     <b>OUT</b>: Destination to write filename to
                      ##    @return             Error code or 0 on success
                      ##   
                      ##    @see uriWindowsFilenameToUriStringA
                      ##    @see uriUriStringToUnixFilenameA
                      ##    @since 0.5.2
                      ## ```
proc uriComposeQueryCharsRequiredW*(queryList: ptr UriQueryListW;
                                    charsRequired: ptr cint): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Calculates the number of characters needed to store the
                      ##    string representation of the given query list excluding the
                      ##    terminator. It is assumed that line breaks are will be
                      ##    normalized to "%0D%0A".
                      ##   
                      ##    @param queryList         <b>IN</b>: Query list to measure
                      ##    @param charsRequired     <b>OUT</b>: Length of the string representation in characters <b>excluding</b> terminator
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriComposeQueryCharsRequiredExA
                      ##    @see uriComposeQueryA
                      ##    @since 0.7.0
                      ## ```
proc uriComposeQueryCharsRequiredExW*(queryList: ptr UriQueryListW;
                                      charsRequired: ptr cint;
                                      spaceToPlus: UriBool;
                                      normalizeBreaks: UriBool): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Calculates the number of characters needed to store the
                      ##    string representation of the given query list excluding the
                      ##    terminator.
                      ##   
                      ##    @param queryList         <b>IN</b>: Query list to measure
                      ##    @param charsRequired     <b>OUT</b>: Length of the string representation in characters <b>excluding</b> terminator
                      ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                      ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriComposeQueryCharsRequiredA
                      ##    @see uriComposeQueryExA
                      ##    @since 0.7.0
                      ## ```
proc uriComposeQueryW*(dest: ptr wchar_t; queryList: ptr UriQueryListW;
                       maxChars: cint; charsWritten: ptr cint): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Converts a query list structure back to a query string.
                      ##    The composed string does not start with '?',
                      ##    on the way ' ' is converted to '+' and line breaks are
                      ##    normalized to "%0D%0A".
                      ##   
                      ##    @param dest              <b>OUT</b>: Output destination
                      ##    @param queryList         <b>IN</b>: Query list to convert
                      ##    @param maxChars          <b>IN</b>: Maximum number of characters to copy <b>including</b> terminator
                      ##    @param charsWritten      <b>OUT</b>: Number of characters written, can be lower than maxChars even if the query list is too long!
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriComposeQueryExA
                      ##    @see uriComposeQueryMallocA
                      ##    @see uriComposeQueryMallocExA
                      ##    @see uriComposeQueryMallocExMmA
                      ##    @see uriComposeQueryCharsRequiredA
                      ##    @see uriDissectQueryMallocA
                      ##    @see uriDissectQueryMallocExA
                      ##    @see uriDissectQueryMallocExMmA
                      ##    @since 0.7.0
                      ## ```
proc uriComposeQueryExW*(dest: ptr wchar_t; queryList: ptr UriQueryListW;
                         maxChars: cint; charsWritten: ptr cint;
                         spaceToPlus: UriBool; normalizeBreaks: UriBool): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a query list structure back to a query string.
                               ##    The composed string does not start with '?'.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param queryList         <b>IN</b>: Query list to convert
                               ##    @param maxChars          <b>IN</b>: Maximum number of characters to copy <b>including</b> terminator
                               ##    @param charsWritten      <b>OUT</b>: Number of characters written, can be lower than maxChars even if the query list is too long!
                               ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                               ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriComposeQueryA
                               ##    @see uriComposeQueryMallocA
                               ##    @see uriComposeQueryMallocExA
                               ##    @see uriComposeQueryMallocExMmA
                               ##    @see uriComposeQueryCharsRequiredExA
                               ##    @see uriDissectQueryMallocA
                               ##    @see uriDissectQueryMallocExA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @since 0.7.0
                               ## ```
proc uriComposeQueryMallocW*(dest: ptr ptr wchar_t; queryList: ptr UriQueryListW): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a query list structure back to a query string.
                               ##    Memory for this string is allocated internally.
                               ##    The composed string does not start with '?',
                               ##    on the way ' ' is converted to '+' and line breaks are
                               ##    normalized to "%0D%0A".
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param queryList         <b>IN</b>: Query list to convert
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriComposeQueryMallocExA
                               ##    @see uriComposeQueryMallocExMmA
                               ##    @see uriComposeQueryA
                               ##    @see uriDissectQueryMallocA
                               ##    @see uriDissectQueryMallocExA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @since 0.7.0
                               ## ```
proc uriComposeQueryMallocExW*(dest: ptr ptr wchar_t;
                               queryList: ptr UriQueryListW;
                               spaceToPlus: UriBool; normalizeBreaks: UriBool): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Converts a query list structure back to a query string.
                               ##    Memory for this string is allocated internally.
                               ##    The composed string does not start with '?'.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param queryList         <b>IN</b>: Query list to convert
                               ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                               ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriComposeQueryMallocA
                               ##    @see uriComposeQueryMallocExMmA
                               ##    @see uriComposeQueryExA
                               ##    @see uriDissectQueryMallocA
                               ##    @see uriDissectQueryMallocExA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @since 0.7.0
                               ## ```
proc uriComposeQueryMallocExMmW*(dest: ptr ptr wchar_t;
                                 queryList: ptr UriQueryListW;
                                 spaceToPlus: UriBool; normalizeBreaks: UriBool;
                                 memory: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Converts a query list structure back to a query string.
                      ##    Memory for this string is allocated internally.
                      ##    The composed string does not start with '?'.
                      ##   
                      ##    @param dest              <b>OUT</b>: Output destination
                      ##    @param queryList         <b>IN</b>: Query list to convert
                      ##    @param spaceToPlus       <b>IN</b>: Whether to convert ' ' to '+' or not
                      ##    @param normalizeBreaks   <b>IN</b>: Whether to convert CR and LF to CR-LF or not.
                      ##    @param memory            <b>IN</b>: Memory manager to use, NULL for default libc
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriComposeQueryMallocA
                      ##    @see uriComposeQueryMallocExA
                      ##    @see uriComposeQueryExA
                      ##    @see uriDissectQueryMallocA
                      ##    @see uriDissectQueryMallocExA
                      ##    @see uriDissectQueryMallocExMmA
                      ##    @since 0.9.0
                      ## ```
proc uriDissectQueryMallocW*(dest: ptr ptr UriQueryListW; itemCount: ptr cint;
                             first: ptr wchar_t; afterLast: ptr wchar_t): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Constructs a query list from the raw query string of a given URI.
                               ##    On the way '+' is converted back to ' ', line breaks are not modified.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param itemCount         <b>OUT</b>: Number of items found, can be NULL
                               ##    @param first             <b>IN</b>: Pointer to first character <b>after</b> '?'
                               ##    @param afterLast         <b>IN</b>: Pointer to character after the last one still in
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriDissectQueryMallocExA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @see uriComposeQueryA
                               ##    @see uriFreeQueryListA
                               ##    @see uriFreeQueryListMmA
                               ##    @since 0.7.0
                               ## ```
proc uriDissectQueryMallocExW*(dest: ptr ptr UriQueryListW; itemCount: ptr cint;
                               first: ptr wchar_t; afterLast: ptr wchar_t;
                               plusToSpace: UriBool;
                               breakConversion: UriBreakConversion): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Constructs a query list from the raw query string of a given URI.
                               ##    Uses default libc-based memory manager.
                               ##   
                               ##    @param dest              <b>OUT</b>: Output destination
                               ##    @param itemCount         <b>OUT</b>: Number of items found, can be NULL
                               ##    @param first             <b>IN</b>: Pointer to first character <b>after</b> '?'
                               ##    @param afterLast         <b>IN</b>: Pointer to character after the last one still in
                               ##    @param plusToSpace       <b>IN</b>: Whether to convert '+' to ' ' or not
                               ##    @param breakConversion   <b>IN</b>: Line break conversion mode
                               ##    @return                  Error code or 0 on success
                               ##   
                               ##    @see uriDissectQueryMallocA
                               ##    @see uriDissectQueryMallocExMmA
                               ##    @see uriComposeQueryExA
                               ##    @see uriFreeQueryListA
                               ##    @since 0.7.0
                               ## ```
proc uriDissectQueryMallocExMmW*(dest: ptr ptr UriQueryListW;
                                 itemCount: ptr cint; first: ptr wchar_t;
                                 afterLast: ptr wchar_t; plusToSpace: UriBool;
                                 breakConversion: UriBreakConversion;
                                 memory: ptr UriMemoryManager): cint {.importc,
    cdecl, impUriHdr.}
  ## ```
                      ##   Constructs a query list from the raw query string of a given URI.
                      ##   
                      ##    @param dest              <b>OUT</b>: Output destination
                      ##    @param itemCount         <b>OUT</b>: Number of items found, can be NULL
                      ##    @param first             <b>IN</b>: Pointer to first character <b>after</b> '?'
                      ##    @param afterLast         <b>IN</b>: Pointer to character after the last one still in
                      ##    @param plusToSpace       <b>IN</b>: Whether to convert '+' to ' ' or not
                      ##    @param breakConversion   <b>IN</b>: Line break conversion mode
                      ##    @param memory            <b>IN</b>: Memory manager to use, NULL for default libc
                      ##    @return                  Error code or 0 on success
                      ##   
                      ##    @see uriDissectQueryMallocA
                      ##    @see uriDissectQueryMallocExA
                      ##    @see uriComposeQueryExA
                      ##    @see uriFreeQueryListA
                      ##    @see uriFreeQueryListMmA
                      ##    @since 0.9.0
                      ## ```
proc uriFreeQueryListW*(queryList: ptr UriQueryListW) {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Frees all memory associated with the given query list.
               ##    The structure itself is freed as well.
               ##   
               ##    @param queryList   <b>INOUT</b>: Query list to free
               ##   
               ##    @see uriFreeQueryListMmA
               ##    @since 0.7.0
               ## ```
proc uriFreeQueryListMmW*(queryList: ptr UriQueryListW;
                          memory: ptr UriMemoryManager): cint {.importc, cdecl,
    impUriHdr.}
  ## ```
               ##   Frees all memory associated with the given query list.
               ##    The structure itself is freed as well.
               ##   
               ##    @param queryList  <b>INOUT</b>: Query list to free
               ##    @param memory     <b>IN</b>: Memory manager to use, NULL for default libc
               ##    @return           Error code or 0 on success
               ##   
               ##    @see uriFreeQueryListA
               ##    @since 0.9.0
               ## ```
proc uriMakeOwnerW*(uri: ptr UriUriW): cint {.importc, cdecl, impUriHdr.}
  ## ```
                                                                         ##   Makes the %URI hold copies of strings so that it no longer depends
                                                                         ##    on the original %URI string.  If the %URI is already owner of copies,
                                                                         ##    this function returns <c>URI_TRUE</c> and does not modify the %URI further.
                                                                         ##   
                                                                         ##    Uses default libc-based memory manager.
                                                                         ##   
                                                                         ##    @param uri    <b>INOUT</b>: %URI to make independent
                                                                         ##    @return       Error code or 0 on success
                                                                         ##   
                                                                         ##    @see uriMakeOwnerMmA
                                                                         ##    @since 0.9.4
                                                                         ## ```
proc uriMakeOwnerMmW*(uri: ptr UriUriW; memory: ptr UriMemoryManager): cint {.
    importc, cdecl, impUriHdr.}
  ## ```
                               ##   Makes the %URI hold copies of strings so that it no longer depends
                               ##    on the original %URI string.  If the %URI is already owner of copies,
                               ##    this function returns <c>URI_TRUE</c> and does not modify the %URI further.
                               ##   
                               ##    @param uri     <b>INOUT</b>: %URI to make independent
                               ##    @param memory  <b>IN</b>: Memory manager to use, NULL for default libc
                               ##    @return        Error code or 0 on success
                               ##   
                               ##    @see uriMakeOwnerA
                               ##    @since 0.9.4
                               ## ```
{.pop.}
