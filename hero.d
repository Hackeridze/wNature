module hero;

import std.stdio;

public import map;
import random;
import color;
import handlers;

static char[11] PlayerNickName = '\n'; /// Ник игрока, Максимум 10 символов
immutable STD_HEALTH = 20;
immutable STD_MANA = 20;
immutable STD_SPELL_POWER = 2; /// ДЕЛАТЬ ВСЕГДА КРАТНЫМ ДВУМ
immutable STD_ATTACK_POWER = 2; /// ДЕЛАТЬ ВСЕГДА КРАТНЫМ ДВУМ
immutable STD_FORTUNE = 0;
immutable STD_REDUCTION = 0;
immutable STD_CRIT_STRIKE_RATE = 0;

static immutable START_COORD = Coord(45, 15); /// Начальные коордлинаты героя, х = 0 и у = 0

/// Координаты
struct Coord {
    int x;
    int y;
    this(int x, int y) {
        this.x = x;
        this.y = y;
    }
}


/**
* Герой
*/
struct Hero {
    char[11] name; /// Имя
    uint health; /// Здоровье
    uint healthNow;
    uint mana; /// Мана
    uint manaNow;
    uint attackPower; /// Сила атаки
    uint spellPower; /// Сила заклинаний
    uint damageReduction; /// Блокировка урона
    uint fortune; /// Удача
    uint critStrikeRate; /// Рейтинг критического удара

    uint armor = 0; /// Броня

    string[32] inventory; /// Инвентарь

    Coord coord = START_COORD;

    void die() {
        if (this.healthNow <= 0) {
            writeln("Ты помер... Пусть ",heroLocalityType()," теюе будет какашкой!");
        }
    }

    /// Функция возвращает рейтинг, да
    float rating() {
        float rating = (((this.health + this.mana)*38)/75 + ((this.attackPower + this.spellPower)*67)/81);
        rating /= 13.2546798511277;
        return rating;
    }
    /// Функция хождения вверх
    bool goUp() {
        if ((this.coord.y - 1) !< 0) this.coord.y--;
        else {  writeln(RED, "НИЗЯ, БАШКОЙ ДУМАЙ! ПРИДЕЛИ КАРТЫ! ЕТА ПЛОХА!", DEFAULT);
                return false;
        }
        coordHandler();
        return true;
    }
    /// Функция хождения вниз
    bool goDown() {
        if ((this.coord.y + 1) !> MAPSIZE - 1) this.coord.y++;
        else {writeln(RED, "НИЗЯ, БАШКОЙ ДУМАЙ! ПРИДЕЛИ КАРТЫ! ЕТА ПЛОХА!", DEFAULT);
        return false;
        }
        coordHandler();
        return true;
    }
    /// Функция хождения влево
    bool goLeft() {
        if ((this.coord.x - 1) !< 0) this.coord.x--;
        else {writeln(RED, "НИЗЯ, БАШКОЙ ДУМАЙ! ПРИДЕЛИ КАРТЫ! ЕТА ПЛОХА!", DEFAULT);
        return false;
        }
        coordHandler();
        return true;
    }
    /// Функция хождения вправо
    bool goRight() {
        if ((this.coord.x + 1) !> MAPSIZE - 1) this.coord.x++;
        else {  writeln(RED, "НИЗЯ, БАШКОЙ ДУМАЙ! ПРИДЕЛИ КАРТЫ! ЕТА ПЛОХА!", DEFAULT);
                return false;
        }
        coordHandler();
        return true;
    }
    /// Конструктор
    this(char[11] name, uint health, uint mana,
            uint attackPower, uint spellPower,
            uint damageReduction, uint fortune,
            uint critStrikeRate) {

        this.name = name;

        this.health = health;
        this.mana = mana;
        this.healthNow = health;
        this.manaNow = mana;

        this.attackPower = attackPower;
        this.spellPower = spellPower;
        this.damageReduction = damageReduction;
        this.fortune = fortune;
        this.critStrikeRate = critStrikeRate;
    }
}

Hero hero;


void printHeroInfo() {

    std.c.stdlib.system("clear");

    printMapMini();
    write(PURPLE);
    write("\033[9A");
    write(" Имя: ", hero.name, "\r\n");
    write(" Здоровье: ", hero.healthNow,'\\', hero.health, "\r\n");
    write(" Мана: ", hero.manaNow,'\\', hero.mana, "\r\n");
    write(" Координаты: [", hero.coord.x,';', hero.coord.y, "]\r\n");
    write(" Местность: ", heroLocalityType(), "\r\n");
    write(" Рейтинг: ", hero.rating(), "\r\n");
    write("\033[5B");
    write(DEFAULT);
}

string heroLocalityType() {
    return map.worldMap[hero.coord.y][hero.coord.x].localityType;
}


void heroGoTo(string to) {

    write("\r\t На сколько клеток? >");
    uint times;
    std.stdio.readf("%d", &times);
    writeln();

    if (to == "up") moveUp(times);
    else if (to == "down") moveDown(times);
    else if (to == "right") moveRight(times);
    else if (to == "left") moveLeft(times);
}

void moveUp(uint times) {
    for (int t = 0; t < times; ++t) {
        if (hero.goUp() == false) break;
    }
}
void moveDown(uint times) {
    for (int t = 0; t < times; ++t) {
        if (hero.goDown() == false) break;
    }
}
void moveRight(uint times) {
    for (int t = 0; t < times; ++t) {
        if (hero.goRight() == false) break;
    }
}
void moveLeft(uint times) {
    for (int t = 0; t < times; ++t) {
        if (hero.goLeft() == false) break;
    }
}


/**
* Функция генерации героя
*/
void heroGenerator(ref Hero genHero) {

    auto type = randomInt(2); /// 1 -- маг, 2 -- воин

    if (type == 1) genHero = Hero(PlayerNickName,
                                  STD_HEALTH - randomInt(6)+1, /// Стандартное ХП минус от 0 до 5
                                  STD_MANA + randomInt(6)-1, /// Стандартная мана плюс от 0 до 5
                                  STD_ATTACK_POWER - (randomInt(STD_ATTACK_POWER/2 + 1) - 1),
                                  STD_SPELL_POWER + (randomInt(STD_SPELL_POWER/2 + 1) - 1),
                                  STD_REDUCTION,
                                  STD_FORTUNE,
                                  STD_CRIT_STRIKE_RATE);

    if (type == 2) genHero = Hero(PlayerNickName,
                                  STD_HEALTH + randomInt(6)-1, /// Стандартное ХП минус от 0 до 5
                                  STD_MANA - randomInt(6)+1, /// Стандартная мана плюс от 0 до 5
                                  STD_ATTACK_POWER + (randomInt(STD_ATTACK_POWER/2 + 1) - 1),
                                  STD_SPELL_POWER - (randomInt(STD_SPELL_POWER/2 + 1) - 1),
                                  STD_REDUCTION,
                                  STD_FORTUNE,
                                  STD_CRIT_STRIKE_RATE);

    exploration();
}






