%%%-------------------------------------------------------------------
%%% @author ryo-py
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. 7 2015 19:10
%%%-------------------------------------------------------------------
-module(kitchen).
-author("ryo-py").
-compile(export_all).

%% API
-export([]).

fridge1() ->
  receive
    {From, {store, _Food}} ->
      From ! {self(), ok},
      fridge1();
    {From, {take, _Food}} ->
      From ! {self(), not_found},
      fridge1();
    terminate ->
      ok
  end.

fridge2(FoodList) ->
  receive
    {From, {store, Food}} ->
      From ! {self(), ok},
      fridge2([Food|FoodList]);
    {From, {take, Food}} ->
      case lists:member(Food,FoodList) of
        true ->
          From ! {self(), {ok, FoodList}},
            fridge2(lists:delete(Food, FoodList));

        false ->
          From ! {self(), not_found},
          fridge2(FoodList)
      end;
    terminate ->
      ok
end.