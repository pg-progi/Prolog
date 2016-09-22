
:-dynamic cnt/1.
:-op(1000,xfy,<*>).
:-op(1001,xfy,->).

cnt(0).

addInd(A) :- assert(curind(A)).
removeInd(A) :- retract(curind(A)).

norm(E1, E2) :- atom(E1),  E2 = E1.
norm(lam(X, E), lam(X,E2)) :- norm(E, E2).
norm(E1<*>E2, E3) :- norm(E1, E11), atom(E2), E3=(E11<*>E2).
norm(E1<*>E2, E3) :- norm(E1, E11), norm(E2, E22), E3=(E11<*>E22).
norm(let([], _), _).
norm(let([(L->T)|LS], E1), let(X, E2)) :- norm(T, ET), append(X, [L->ET], R), norm(let(LS, E1), let(R, E2)), norm(E1, E2), writeln(R).
norm(E1<*>E2, E3) :-  cnt(K), KK is K+1, atom_concat('Z', KK, R), corAdd(R, E2), E3=(E1<*>R).
norm(E1, E2) :- number(E1), cnt(K), KK is K+1, atom_concat('Z',KK, R), corAdd(R, E2), E2 = R.

corAdd(X,Y) :- assert(bd(X,Y)), retract(cnt(K)), S is K + 1, assert(cnt(S)).
