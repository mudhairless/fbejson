''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include once "json.bi"
#include once "crt/string.bi"

namespace json

operator JSONpair.cast() as string
    return !"\"" & key & !"\"" & " : " & *value
end operator

constructor JSONpair( byref k as const string, byval v as JSONvalue ptr )
    key = k
    value = v
end constructor

function JSONpair.toBSON( byref buf_len as ulong ) as ubyte ptr

    var vbuf_len = 0ul
    var vbuf = value->toBSON(vbuf_len)

    buf_len = vbuf_len + len(key) + 1
    dim ret as ubyte ptr
    ret = new ubyte[buf_len]
    ret[0] = vbuf[0]
    memcpy(@(ret[1]),@(key[0]),len(key))
    ret[len(key)+1] = 0
    memcpy(@(ret[len(key)+2]),@(vbuf[1]),vbuf_len-1)
    delete[] vbuf

    return ret

end function

destructor JSONpair
    key = ""
    if value <> 0 then delete value
end destructor

end namespace
