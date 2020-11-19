{.passL: "-luriparser".}

import uriparserapi

let original: string = "hölidäys in the 🏖️X&*! sun"
var modified = escape(original)
echo "escaped:",modified
unescape(modified)
echo "original:",modified
assert(modified == original) 
echo "---"

const uriString = "http://127.192.0.1:8080/w3c/user/song.mp3?q=4345&a=sun#fraggle"
var errorPos: cstring
var uri: UriUriA
withUri(uri):
  echo "success: ", parse(uri, uriString, errorPos)
  echo "scheme: ", uri.getScheme()
  echo "userinfo: ", uri.getUserInfo()
  echo "ip4: ", uri.getIp4()
  echo "port: ", uri.getPortText()
  echo "path: ", uri.getPath()
  echo "query: ", uri.getQuery()
  echo "parsedquery: ", uri.dissectQuery()
  echo "fragment: ", uri.getFragment()
  echo "is absolute: ", uri.isAbsolutePath()
echo "---"

let originalname = "/home/homelius/a.out"
echo "filename:", originalname,":"
var modifiedname = unixFilenameToUri(originalname)
echo "fileuri: ", modifiedname
modifiedname = uriToUnixFilename(modifiedname)
assert(modifiedname == originalname)