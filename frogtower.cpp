#include "frogtower.h"

FrogTower::FrogTower() {

}

void FrogTower::moveImage(QMouseEvent mouse) {
    setX(mouse.position().x());
    setY(mouse.position().y());
}

void FrogTower::setImage(QMouseEvent mouse) {

}

void FrogTower::setX(const int newX) {x = newX;}
void FrogTower::setY(const int newY) {y = newY;}

int FrogTower::X() const {return x;}
int FrogTower::Y() const {return y;}
