%%%-------------------------------------------------------------------
%%% @author ryo-py
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. 7 2015 16:19
%%%-------------------------------------------------------------------
-module(dolphins).
-author("ryo-py").
-compile(export_all).

%% API
dolphin2() ->
  receive
    {From, do_a_flip} ->
      From ! "How about no?";
    {From, fish} ->
      From ! "So long and thanks for all the fish!";
    _ ->
      io:format("heh, we're smarter than you humans.~n")
  end.