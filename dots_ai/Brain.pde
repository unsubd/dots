class Brain {

  PVector[] directions;
  int step = 0;

  Brain(int size) {
    directions = randomDirections(size);
  }

  PVector[] randomDirections(int size) {

    PVector[] directions = new PVector[size];
    for (int i=0; i<size; i++) 
      directions[i] = PVector.fromAngle(random(2*PI));

    return directions;
  }

  Brain clone() {
    Brain clone = new Brain(directions.length);
    for (int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }

    return clone;
  }

  void mutate() {
    float mutationRate = 0.01;
    for (int i=0; i<directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        directions[i] = PVector.fromAngle(random(2*PI));
      }
    }
  }
}
