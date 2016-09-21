
:-dynamic cnt/1.
:-op(1000,xfy,<*>).
:-op(2000,xfy,->).

cnt(0).

addInd(A) :- assert(curind(A)).
removeInd(A) :- retract(curind(A)).

norm(E1, E2) :- atom(E1),  E2 = E1.
norm(lam(X, E), lam(X,E2)) :- norm(E, E2).
norm(E1<*>E2, E3) :- norm(E1, E11), atom(E2), norm(E2, E22), atom_concat(E11, '<*>', E111), atom_concat(E111, E22, E3).
norm(let([], _), _).
norm(let([(L->T)|LS], E1), let(X, E2)) :- norm(T, ET), append(X, [L->ET], R), norm(let(LS, E1), let(R, E2)), norm(E1, E2).
norm(E1<*>E2, E3) :-  cnt(K), KK is K+1, atom_concat('Z', KK, R), corAdd(R, E2), atom_concat(E1, '<*>', EE), atom_concat(EE, R, E3).

corAdd(X,Y) :- assert(bd(X,Y)), retract(cnt(K)), S is K + 1, assert(cnt(S)).
