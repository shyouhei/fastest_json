# -*- mode: ruby; coding: utf-8 -*- 
FastestJson = Regexp.compile(<<-'end', Regexp::EXTENDED).freeze

    # RFC7159 section 2

    (?<json-text>        \g<ws> \g<value> \g<ws> ){0}

    (?<begin-array>      \g<ws> \x5B \g<ws>      ){0} # [ left square bracket

    (?<begin-object>     \g<ws> \x7B \g<ws>      ){0} # { left curly bracket

    (?<end-array>        \g<ws> \x5D \g<ws>      ){0} # ] right square bracket

    (?<end-object>       \g<ws> \x7D \g<ws>      ){0} # } right curly bracket

    (?<name-separator>   \g<ws> \x3A \g<ws>      ){0} # : colon

    (?<value-separator>  \g<ws> \x2C \g<ws>      ){0} # , comma

    (?<ws>               [\x20\x09\x0A\x0D]*     ){0} # \s \t \r \n


    # RFC7159 section 3

    (?<value>  false | null | true | \g<object> | \g<array> | \g<number> | \g<string> ){0}


    # RFC7159 section 4

    (?<object> \g<begin-object> (?: \g<member> (?: \g<value-separator> \g<member>)* )?
               \g<end-object> ){0}

    (?<member> \g<string> \g<name-separator> \g<value> ){0}


    # RFC7159 section 5

    (?<array> \g<begin-array> (?: \g<value> (?: \g<value-separator> \g<value>)* )? \g<end-array> ){0}


    # RFC7159 section 6

    (?<number> -? \g<int> \g<frac>? \g<exp>? ){0}

    (?<exp>    [eE] [-+] \d+                 ){0}

    (?<frac>   \. \d+                        ){0}

    (?<int>    0 | [1-9] \d*                 ){0}


    # RFC7159 section 7

    (?<string>  " \g<char>* " ){0}

    (?<char>    \g<unescaped>
              | \x5C [\x22\x5C\x2F\x62\x66\x6E\x72\x74]
              | \x5C \x75 \h{4}
    ){0}

    (?<unescaped> [\x20\x21]
                | [\x23-\x5b]
                | [\x5D-\u{10ffff}]
    ){0}

    # entry point
    \A \g<json-text> \z
end
