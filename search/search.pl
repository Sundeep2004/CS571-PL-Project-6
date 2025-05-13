%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here:
%%%%%%%%%%%%%%%%%%%%%%

% state(Room, KeysHeld, DoorsUnlocked)

initial_state(state(Room, [], [])) :- initial(Room).

connected(RoomA, RoomB) :- door(RoomA, RoomB).
connected(RoomA, RoomB) :- door(RoomB, RoomA).

locked_connection(RoomA, RoomB, Color) :- locked_door(RoomA, RoomB, Color).
locked_connection(RoomA, RoomB, Color) :- locked_door(RoomB, RoomA, Color).

final_state(state(Room, _, _)) :- treasure(Room).

perform_move(state(Room, KeysHeld, DoorsUnlocked), move(Room, NextRoom), state(NextRoom, KeysHeld, DoorsUnlocked)) :- 
    connected(Room, NextRoom).

perform_move(state(Room, KeysHeld, DoorsUnlocked), move(Room, NextRoom), state(NextRoom, [NewKey | KeysHeld], DoorsUnlocked)) :- 
    connected(Room, NextRoom),
    key(NextRoom, NewKey).

perform_move(state(Room, KeysHeld, DoorsUnlocked), move(Room, NextRoom), state(NextRoom, KeysHeld, DoorsUnlocked)) :- 
    locked_connection(Room, NextRoom, LockColor),
    member(LockColor, DoorsUnlocked).

perform_move(state(Room, KeysHeld, DoorsUnlocked), move(Room, NextRoom), state(NextRoom, [NewKey | KeysHeld], DoorsUnlocked)) :- 
    locked_connection(Room, NextRoom, LockColor),
    member(LockColor, DoorsUnlocked),
    key(NextRoom, NewKey).

perform_move(state(Room, KeysHeld, DoorsUnlocked), unlock(Color), state(Room, KeysHeld, [Color | DoorsUnlocked])) :-
    locked_connection(Room, _, Color),
    member(Color, KeysHeld).

perform_sequence(StateStart, [Action], StateEnd) :-
    perform_move(StateStart, Action, StateEnd).

perform_sequence(StateStart, [Action | RemainingActions], StateFinal) :-
    perform_move(StateStart, Action, IntermediateState),
    perform_sequence(IntermediateState, RemainingActions, StateFinal).

search(Actions) :-
    length(Actions, _),
    initial_state(StartState),
    perform_sequence(StartState, Actions, EndState),
    final_state(EndState), !.