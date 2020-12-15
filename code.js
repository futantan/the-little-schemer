const isAtom = (v) => typeof v === 'number' || typeof v === 'string'
const isNull = (v) => Array.isArray(v) && v.length === 0
const isEq = (l, r) => isAtom(l) && isAtom(r) && l === r
const quote = () => []

const car = (l) => l[0]
const cdr = (l) => l.slice(1)
const cons = (a, l) => [a, ...l]

// Are all items in list are atoms?
const isLat = (l) =>
  (isNull
    ? true
    : isAtom(car(l))
        ? isLat(cdr(l))
        : false)

const or = (l, r) => l || r

const isMember = (a, lat) =>
  isNull(lat)
    ? false
    : (or((isEq(car(lat), a)),
           isMember(a, cdr(lat))))
// isMember('meat', ['mashed', 'meat']) //?

// remove first a in list
const rember = (a, lat) =>
  isNull(lat)
    ? quote()
    : (isEq(car(lat), a)
        ? cdr(lat)
        : cons(car(lat), rember(a, cdr(lat))))

// rember('sauce', ['soy', 'sauce', 'and', 'tomato', 'sauce']) //?
const firsts = (l) =>
  isNull(l)
    ? quote()
    : cons(car(car(l)), firsts(cdr(l)))

// firsts([
//   ['apple', 'peach', 'pumpkin'],
//   ['plum', 'pear', 'cherry'],
//   ['grape', 'raisin', 'pea'],
// ]) //?

const insertR = (val, old, lat) =>
  isNull(lat)
    ? quote()
    : (isEq(car(lat), old)
        ? cons(old, cons(val, cdr(lat)))
        : cons(car(lat), insertR(val, old, cdr(lat))))
// insertR('e', 'd', ['a', 'b', 'c', 'd', 'f']) //?

const subst = (val, old, lat) =>
  isNull(lat)
    ? quote()
    : (isEq(car(lat), old)
        ? cons(val, cdr(lat))
        : cons(car(lat), subst(val, old, cdr(lat))))

// subst('e', 'd', ['a', 'b', 'c', 'd', 'f']) //?

const subst2 = (val, o1, o2, lat) =>
  isNull(lat)
    ? quote()
    : (or((isEq(car(lat), o1), isEq(car(lat), o2))
      ? cons(val, cdr(lat))
      : cons(car(lat), subst2(val, o1, o2, cdr(lat)))))
// subst2('vanilla', 'chocolate', 'banana', ['banana', 'ice', 'cream', 'with', 'chocolate', 'topping']) //?

const multirember = (a, lat) =>
  isNull(lat)
    ? quote()
    : (isEq(a, car(lat))
      ? multirember(a, cdr(lat))
      : cons(car(lat), multirember(a, cdr(lat))))
// multirember('cup', ['coffee', 'cup', 'tea', 'cup', 'and', 'hick', 'cup']) //?

const isZero = (v) => v === 0
const add1 = (v) => v + 1
const sub1 = (v) => v - 1

const add = (n, m) =>
  isZero(m)
    ? n
    : add1(add(n, sub1(m)))

// add(3, 4) //?

const addup = (tup) =>
  isNull(tup)
    ? 0
    : add(car(tup), addup(cdr(tup)))

// addup([1,2,3,4,5])//?

const multiply = (n, m) =>
  isZero(m)
    ? 0
    : add(n, multiply(n, sub1(m)))
// multiply(3, 4) //?
