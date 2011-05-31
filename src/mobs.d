/*
* Copyright (c) 201>, Victor Hackeridze All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
*     Redistributions of source code must retain the above copyright notice, this
* list of conditions and the following disclaimer.
*     Redistributions in binary form must reproduce the above copyright notice, this
* list of conditions and the following disclaimer in the documentation and/or other
* materials provided with the distribution.
*     Neither the name of the <HACKERIDZE's BRAIN> nor the names of its
* contributors may be used to endorse or promote products derived from this
* software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
* IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
* INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
* NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
* ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
* POSSIBILITY OF SUCH DAMAGE.
*/
module mobs;

import random;
import map;
import hero;
import std.stdio;

struct Mob {
    string name;
    uint health;
    uint attackPower;
    uint spellPower;
    ulong id;
    string habitat;


    /// Функция возвращает рейтинг, да
    float rating() {
        float rating = (((health*2)*38)/75 + ((attackPower + spellPower)*67)/81);
        rating /= 13.2546798511277;
        return rating;
    }

    this(string name, uint health, uint attackPower,
            uint spellPower, string habitat, ulong id) {
        this.name = name;
        this.health = health;
        this.attackPower = attackPower;
        this.spellPower = spellPower;
        this.id = id;
        this.habitat = habitat;
    }
}

ulong[] generateMobs() {

    ushort counter = 0;
    auto suitableByLocality = new ulong[1];
    auto suitable = new ulong[1];

    for(ulong id = 0; id < NUMBER_OF_MOBS; ++id) {

        Mob bufferMob = get(id);

        if ( bufferMob.habitat == heroLocalityType() ) {
            suitableByLocality ~= id;
            counter++;
        }

    }

    counter = 0;

    for(ulong t = 0; t < suitableByLocality.length; ++t) {
        Mob bufferMob = get(suitableByLocality[t]);
        if ( bufferMob.rating() <= hero.hero.rating() ) {
            suitable ~= suitableByLocality[t];
        }
    }
    return suitable;
}

Mob get(const ulong id) {
    switch (id) {
        case 0: return boar();
        break;
        case 1: return wolf();
        break;
        case 2: return bear();
        break;
        case 3: return crocodile();
        break;
        case 4: return rat();
        break;
        case 5: return tiger();
        break;
        case 6: return spider();
        break;
        case 7: return elephant();
        break;
        case 8: return wolverine();
        break;
        case 9: return crucian();
    }
}

/// Всего мобов:
immutable NUMBER_OF_MOBS = 10; /// ID последнего + 1


static Mob boar() { /// "boar()" -- название ф-ции
    string name = "Кабан"; /// Имя
    uint health = 7 + randomInt(3);/// Значит, что будет 8-10 ХП, рандом инт возвращает от 1 до max(тут равно 3)
    uint attackPower = 3; /// Сила атаки
    uint spellPower = 0; /// СПД
    ulong id = 0; /// ID
    string habitat = "forest";/// Среда обитания, бывает bank jungle mountains plain desert water shoal forest

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob wolf() {
    string name = "Волк";
    uint health = 5 + randomInt(4);
    uint attackPower = 6;
    uint spellPower = 0;
    ulong id = 1;
    string habitat = "forest";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob bear() {
    string name = "Медведь";
    uint health = 8 + randomInt(4);
    uint attackPower = 9;
    uint spellPower = 0;
    ulong id = 2;
    string habitat = "forest";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob crocodile() {
    string name = "Крокодил";
    uint health = 7 + randomInt(4);
    uint attackPower = 7;
    uint spellPower = 0;
    ulong id = 3;
    string habitat = "shoal";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob rat() {
    string name = "Крыса";
    uint health = 2 + randomInt(2);
    uint attackPower = 2;
    uint spellPower = 0;
    ulong id = 4;
    string habitat = "plain";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob tiger() {
    string name = "Тигр";
    uint health = 8 + randomInt(3);
    uint attackPower = 10;
    uint spellPower = 0;
    ulong id = 5;
    string habitat = "plain";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob spider() {
    string name = "Паук";
    uint health = 1 + randomInt(2);
    uint attackPower = 1;
    uint spellPower = 0;
    ulong id = 6;
    string habitat = "forest";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob elephant() {
    string name = "Слон";
    uint health = 13 + randomInt(5);
    uint attackPower = 15;
    uint spellPower = 0;
    ulong id = 7;
    string habitat = "plain";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob wolverine() {
    string name = "Росомаха";
    uint health = 7 + randomInt(3);
    uint attackPower = 11;
    uint spellPower = 0;
    ulong id = 8;
    string habitat = "jungle";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

static Mob crucian() {
    string name = "Карась";
    uint health = 0 + randomInt(2);
    uint attackPower = 1;
    uint spellPower = 0;
    ulong id = 9;
    string habitat = "shoal";

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id);
    return mob;
}

