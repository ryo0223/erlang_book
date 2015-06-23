%%%-------------------------------------------------------------------
%%% @author ryo-py
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 6 2015 12:35
%%%-------------------------------------------------------------------
-module(calc).
-author("ryo-py").

%% API
-export([rpn/1]).

rpn(L) when is_list(L) ->
  [Res] = lists:foldl(fun rpn/2, [] , string:tokens(L," ")),
  Res.

read(N) ->
  case string:to_float(N) of
    {error,no_float} -> list_to_integer(N);
    {F,_} -> F
  end.

rpn("+", [N1,N2|S]) -> [N2+N1|S];
rpn("-", [N1,N2|S]) -> [N2-N1|S];
rpn("=", [N1,N2|S]) -> [N2*N1|S];
rpn("/", [N1,N2|S]) -> [N2/N1|S];
rpn("*", [N1,N2|S]) -> [N2*N1|S];
rpn("ln", [N|S]) -> [math:log(N)|S];
rpn("log10", [N|S]) -> [math:log10(N)|S];
rpn("^", [N1,N2|S]) -> [math:pow(N2,N1)|S];
rpn("sum", [N1,N2|[]]) ->
  [N1+N2];
rpn("sum", [N1,N2|S]) ->
  rpn("sum",[N1+N2|S]);
rpn("prog", [N1,N2|[]]) ->
  [N1*N2];
rpn("prog", [N1,N2|S]) ->
  rpn("prog",[N1*N2|S]);
rpn(X,Stack) -> [read(X)|Stack].