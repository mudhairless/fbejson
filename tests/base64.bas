#include once "base64.bi"

const hw_base64 = "SGVsbG8sIFdvcmxkIQ=="
const hellow = "Hello, World!"

function stringcompare( byref rhs as const string, byref lhs as const string ) as boolean

    var len_r = len(rhs) - 1
    var len_l = len(lhs) - 1

    var len_u = len_r
    if len_l < len_r then len_u = len_l

    for n as integer = 0 to len_u
        if rhs[n] <> lhs[n] then return false
    next

    return true

end function

var encodedResult = base64.encode(hellow)
if (stringcompare(encodedResult, hw_base64)) then
    print "BASE64 Encoding is working"
else
    print "BASE64 Encoding is not working"
end if

var decodedResult = ""
base64.decode(decodedResult, hw_base64)
if (stringcompare(decodedResult, hellow)) then
    print "BASE64 Decoding is working"
else
    print "BASE64 Decoding is not working"
end if
