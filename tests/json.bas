#include once "json.bi"

#macro assert_true(x)
    if ((x) = true) then
        print __FUNCTION__ & " " & #x & " is working"
    else 
        print __FUNCTION__ & " " & #x & " is NOT working"
    end if
#endmacro

#macro assert_false(x)
    if ((x) = false) then
        print __FUNCTION__ & " " & #x & " is working"
    else 
        print __FUNCTION__ & " " & #x & " is NOT working"
    end if
#endmacro

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

sub test_create

    dim x as uinteger
    dim j as json.JSONobject

    j.addChild("one",new json.JSONvalue(1))
    
    assert_true(j.hasChild("one", x))
    assert_true(x = 0)

    var nb = new json.JSONvalue(true)
    
    j.addChild("test",new json.JSONvalue(true))
    assert_true(j.hasChild("test", x))
    assert_true(x = 1)

    dim as string test
    test = j

    assert_true( stringcompare(test, !"{ \"one\" : 1, \"test\" : true }"))
    'and test removing
    
    j.removeChild("test")
    assert_false(j.hasChild("test"))
    assert_true( j.children = 1 )

end sub

sub test_create_array_adv

    dim j as json.JSONobject

    dim as json.JSONvalue ptr ptr arr

    arr = new json.JSONvalue ptr[10]

    for n as uinteger = 0 to 9
        arr[n] = new json.JSONvalue(n)
    next

    j.addChild("array",new json.JSONvalue(new json.JSONarray(arr,10)))

    dim as string test
    test = j

    assert_true( stringcompare(test, !"{ \"array\" : [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ] }"))


end sub

sub test_create_blank

    dim j as json.JSONobject
    dim t as string
    t = j

    assert_true( stringcompare(t, "{}") )

end sub

sub test_create_from_string

    var test_str = !"{ \"one\" : 1, \"test\" : true }"

    dim as json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    assert_true( stringcompare(t, test_str) )

end sub

sub test_create_from_string_array
    var test_str = !"{ \"array\" : [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ] }"

    dim as json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    assert_true( stringcompare(t, test_str) )

end sub

sub test_create_from_string_obj
    var test_str = !"{ \"obj\" : [ 1, { \"this\" : true } ] }"

    dim as json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    assert_true( stringcompare(t, test_str) )

end sub

sub test_create_null_array
    var test_arr = json.JSONarray(10)
    for n as uinteger = 0 to 9
        var tv = test_arr.at(n)
        assert_true( tv->valueType() = json.jvalue_type.jnull )
    next
end sub

test_create()
test_create_array_adv()
test_create_blank()
test_create_from_string()
test_create_from_string_array()
test_create_from_string_obj()
test_create_null_array()
