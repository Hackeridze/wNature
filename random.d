module random;

import std.random;

/**
* Возвращает случайное число от 1 до max
*/
uint randomInt(uint max) {
    auto rnd0 = MinstdRand0(1);
    auto n = rnd0.front;
    rnd0.seed(unpredictableSeed);
    n = rnd0.front;
    n %= max;
    return n + 1;
}
