time(bono,5).
time(theEdge,10).
time(adamClayton,20).
time(larryMullenJr,25).

stars([bono,theEdge,adamClayton,larryMullenJr]).

cost([],0) :- !.
cost([X|L],C) :- 
     time(X,S), 
     cost(L,D), 
     C is max(S,D).

split(L,[X,Y],M) :- 
     member(X,L),
     member(Y,L),
     compare(<,X,Y),  
     subtract(L,[X,Y],M).

move(st(b,L1),st(s,L2),s(M),D) :- 
     split(L1,M,L2),
     cost(M,D).

move(st(s,L1),st(b,L2),b(X),D) :-
     stars(T),
     subtract(T,L1,R),
     member(X,R),
     merge_set([X],L1,L2),
     time(X,D).

trans(st(s,[]),st(s,[]),[],0).    
trans(S,U,L,D) :-
     move(S,T,M,X),
     trans(T,U,N,Y),
     append([M],N,L),
     D is X + Y.

cross(M,D) :-
     stars(T),
     trans(st(b,T),st(s,[]),M,D0),
     D0=<D.

solution(M) :- cross(M,60).
