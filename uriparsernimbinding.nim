# Public Domain

import uriparsernimbinding/uriparserheaders
export UriUriA

const
  LineBreak {.intdefine.} = URI_BR_TO_LF
  True = 1.UriBool

type QueryItem* = object
  key*: string
  value*: string



proc getScheme*(uri: UriUriA): string =
  result = $uri.scheme.first
  result.setLen(cast[uint](uri.scheme.afterLast) - cast[uint](uri.scheme.first))


proc getUserInfo*(uri: UriUriA): string =
  result = $uri.userInfo.first
  result.setLen(cast[uint](uri.userInfo.afterLast) - cast[uint](uri.userInfo.first))


proc gethostText*(uri: UriUriA): string =
  result = $uri.hostText.first
  result.setLen(cast[uint](uri.hostText.afterLast) - cast[uint](uri.hostText.first))


proc getIp4*(uri: UriUriA): array[4, char] =
  if uri.hostData.ip4 != nil: return uri.hostData.ip4.data


proc getIp6*(uri: UriUriA): array[16, char] =
  if uri.hostData.ip6 != nil: return uri.hostData.ip6.data


proc getPortText*(uri: UriUriA): string =
  result = $uri.portText.first
  result.setLen(cast[uint](uri.portText.afterLast) - cast[uint](uri.portText.first))


proc getPath*(uri: UriUriA): seq[string] =
  var current = uri.pathHead
  while current != nil:  
    var segment = $current.text.first
    segment.setLen(cast[uint](current.text.afterLast) - cast[uint](current.text.first))
    result.add(segment)
    if current == uri.pathTail: break
    current = current.next
    

proc getQuery*(uri: UriUriA): string =
  result = $uri.query.first
  result.setLen(cast[uint](uri.query.afterLast) - cast[uint](uri.query.first))


proc dissectQuery*(uri: UriUriA): seq[QueryItem] =
  var queryList: ptr UriQueryListA
  var itemCount: cint
  if uriDissectQueryMallocExA(addr queryList, addr itemCount, uri.query.first, uri.query.afterLast, True, LineBreak) != URI_SUCCESS: return
  try:
    while queryList != nil:
      var item: QueryItem
      item.key = $queryList.key
      item.value = $queryList.value
      result.add(item) 
      queryList = queryList.next
  finally: uriFreeQueryListA(queryList)


proc getFragment*(uri: UriUriA): string =
  result = $uri.fragment.first
  result.setLen(cast[uint](uri.fragment.afterLast) - cast[uint](uri.fragment.first))


proc isAbsolutePath*(uri: UriUriA): bool =
  return uri.absolutePath == True 


template withUri*(uri: UriUriA, body: untyped) =
  try: body
  finally: uriFreeUriMembersA(unsafeAddr uri)


template unescape*(cs: cstring) =
  discard uriUnescapeInPlaceExA(cs, True, LineBreak)


proc parseUri(uri: ptr UriUriA, uriString: cstring, errorPos: cstring): bool =
  return uriParseSingleUriA(uri, uriString, unsafeAddr errorPos) == URI_SUCCESS


template parse*(uri: UriUriA, uriString: cstring, errorPos: cstring): bool =
  parseUri(unsafeAddr uri, uriString, errorPos)


proc escape*(s: cstring): cstring =
  result = newString(6 * s.len())
  discard uriEscapeExA(s, unsafeAddr(s[s.len()]), result, True, True)


proc unixFilenameToUri*(filename: cstring): cstring =
  let bytesNeeded = 7 + 3 * len(filename) + 1
  result = newString(bytesNeeded)
  if uriUnixFilenameToUriStringA(filename, addr result[0]) != 0: return ""


proc uriToUnixFilename*(uriString: cstring): cstring =
  let bytesNeeded = len(uriString) + 1
  result = newString(bytesNeeded)
  if uriUriStringToUnixFilenameA(uriString, addr result[0]) != 0: return ""
