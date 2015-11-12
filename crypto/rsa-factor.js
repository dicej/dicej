"use strict";

let bigint = require('bigint');

let N = bignum("179769313486231590772930519078902473361797697894230657273430081157732675805505620686985379449212982959585501387537164015710139858647833778606925583497541085196591615128057575940752635007475935288710823649949940771895617054361149474865046711015101563940680527540071584560878577663743040086340742855278549092581");

let A = N.root(2);

let x = A.pow(2).sub(N).root(2);

let p = A.sub(x);

let q = A.add(x);

console.log("A   " + A.toString());
console.log("p   " + p.toString());
console.log("q   " + q.toString());
console.log("p*q " + p.mul(q).toString());
console.log("N   " + N.toString());
