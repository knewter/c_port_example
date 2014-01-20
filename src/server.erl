-module(server).
-export([start/1]).

start(Port) ->
  {ok, LSock} = gen_tcp:listen(Port, [binary, {packet, 0}, {active, false}]),
  do_accept(LSock).

do_accept(LSock) ->
  {ok, Sock} = gen_tcp:accept(LSock),
  do_receive(Sock),
  do_accept(LSock).

do_receive(Sock) ->
  case gen_tcp:recv(Sock, 0) of
    {ok, Data} ->
      gen_tcp:send(Sock, Data);
    {error, closed} ->
      ok
  end.
