:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

% The predicate server(+Port) starts the server. It simply creates a
% number of Prolog threads and then returns to the toplevel, so you can
% (re-)load code, debug, etc.
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

% Declare a handler, binding an HTTP path to a predicate.
% Here our path is / (the root) and the goal we'll query will be
% say_hi. The third argument is for options
:- http_handler(/, say_hi, []).
:- http_handler('/image.png', image, []).

/* The implementation of /. The single argument provides the request
details, which we ignore for now. Our task is to write a CGI-Document:
a number of name: value -pair lines, followed by two newlines, followed
by the document content, The only obligatory header line is the
Content-type: <mime-type> header.
Printing can be done using any Prolog printing predicate, but the
format-family is the most useful. See format/2.   */

say_hi(_Request) :-
        format('Content-type: text/plain~n~n'),
        format('Hello World!~n').

image(_Request) :-
    format('Content-type: image/png~n~n'),
    format('\x89\\x50\\x4e\\x47\\x0d\\x0a\\x1a\\x0a\\x00\\x00\\x00\\x0d\\x49\\x48\\x44\\x52\'),
    format('\x00\\x00\\x00\\x20\\x00\\x00\\x00\\x20\\x01\\x00\\x00\\x00\\x00\\x5b\\x01\\x47\'),
    format('\x59\\x00\\x00\\x00\\x04\\x67\\x41\\x4d\\x41\\x00\\x01\\x86\\xa0\\x31\\xe8\\x96\'),
    format('\x5f\\x00\\x00\\x00\\x5b\\x49\\x44\\x41\\x54\\x78\\x9c\\x2d\\xcc\\xb1\\x09\\x03\'),
    format('\x30\\x0c\\x05\\xd1\\xeb\\xd2\\x04\\xb2\\x4a\\x20\\x0b\\x7a\\x34\\x6f\\x90\\x15\'),
    format('\x3c\\x82\\xc1\\x8d\\x0a\\x61\\x45\\x07\\x51\\xf1\\xe0\\x8a\\x2f\\xaa\\xea\\xd2\'),
    format('\xa4\\x84\\x6c\\xce\\xa9\\x25\\x53\\x06\\xe7\\x53\\x34\\x57\\x12\\xe2\\x11\\xb2\'),
    format('\x21\\xbf\\x4b\\x26\\x3d\\x1b\\x42\\x73\\x25\\x25\\x5e\\x8b\\xda\\xb2\\x9e\\x6f\'),
    format('\x6a\\xca\\x30\\x69\\x2e\\x9d\\x29\\x61\\x6e\\xe9\\x6f\\x30\\x65\\xf0\\xbf\\x1f\'),
    format('\x10\\x87\\x49\\x2f\\xd0\\x2f\\x14\\xc9\\x00\\x00\\x00\\x00\\x49\\x45\\x4e\\x44\'),
    format('\xae\\x42\\x60\\x82\').
