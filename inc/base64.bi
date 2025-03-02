''Title: base64.bi
''
''About: License
''Copyright (c) 2025 Ebben Feagan
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Contains code contributed and Copyright (c) 2007, Daniel Verkamp (DrV) http://drv.nu
''
''Contains code contributed and Copyright (c) 2010, D.J. Peters <d.j.peters@web.de>
''
''  Distributed under the Modified BSD license.
''  See accompanying file LICENSE

#ifndef FBBASE64_BI__
#define FBBASE64_BI__ -1

#ifndef null
const null = cast(any ptr, 0)
#endif

#inclib "fbbase64"

''Namespace: base64

namespace base64

    ''Function: encode
    ''Encodes data into base64
    ''
    ''Parameters:
    ''source - pointer to the raw data to be encoded
    ''source_len - the size of the source data
    ''
    ''Returns:
    ''A base64 encoded representation of the data.
    declare function encode overload ( byval src as const ubyte ptr, byval s_l as uinteger ) as string

    ''Function: encode
    ''Encodes data into base64
    ''
    ''Parameters:
    ''source - string to be encoded
    ''
    ''Returns:
    ''A base64 encoded representation of the data.
    declare function encode overload ( byref src as const string ) as string

    ''Sub: decode
    ''Decodes base64 encoded data into its raw binary form.
    ''
    ''Parameters:
    ''dest - ubyte ptr where data will go.
    ''source - pointer to base64 encode data.
    ''source_length - the length in bytes of the source data.
    ''
    declare sub decode overload (byval dest as ubyte ptr, byval source as const ubyte ptr, byval source_length as uinteger)

    ''Sub: decode
    ''Decodes a base64 encoded string into a unencoded string.
    ''
    ''Parameters:
    ''dest - string where decoded data will go.
    ''source - string holding encoded data.
    ''
    declare sub decode overload (byref dest as string, byref source as const string )

    ''Function: decoded_length
    ''Gives the decoded length of a base64 encoded buffer for sizing the destination buffer.
    ''
    ''Parameters:
    ''source_length - uinteger containing the length of the source in bytes.
    ''
    ''Returns:
    ''uinteger containing the total length of the raw data.
    ''
    declare function decoded_length (byval source_length as uinteger) as uinteger

end namespace 'base64

#endif
