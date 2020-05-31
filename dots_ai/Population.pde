class Population {  //<>//
  Dot[] dots; 
  float fitnessSum;
  Dot bestDot;
  int minStep = Integer.MAX_VALUE;
  int gen = 0;

  Population (int size) {
    dots = new Dot[size];
    for (int i = 0; i< size; i++)
      dots[i] = new Dot(gen, i);
    bestDot = dots[0];
  }

  void show() {
    for (int i=0; i<dots.length; i++)
      if (dots[i].isBest || showAll)
        dots[i].show();
  }

  void move() {

    for (int i=0; i<dots.length; i++) {
      if (dots[i].brain.step > minStep) {
        dots[i].alive = false;
      }
      dots[i].update();
    }
  }

  boolean extinct() {
    for (int i=0; i<dots.length; i++)
      if (dots[i].alive && !dots[i].reachedGoal)
        return false;
    return true;
  }

  void computeFitness() {
    float max = 0;

    for (int i=0; i<dots.length; i++) {
      dots[i].computeFitness();
      fitnessSum += dots[i].fitness;
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        bestDot = dots[i];
      }
    }

    if (bestDot.reachedGoal && minStep > bestDot.brain.step) {
      minStep = bestDot.brain.step;
    }
  }

  void createNextGeneration() {
    gen++;

    for (int i=1; i<dots.length; i++) {
      dots[i] = selectParent().getChild(gen, i);
    }

    dots[0] = bestDot.getChild(0, 0);
    dots[0].id = bestDot.id;
    dots[0].isBest = true;
  }

  Dot selectParent() {
    float rand = random(fitnessSum);


    float runningSum = 0;

    for (int i = 0; i< dots.length; i++) {
      runningSum+= dots[i].fitness;
      if (runningSum > rand) {
        return dots[i];
      }
    }

    rand = random(dots.length);
    int sum = 0;
    for (int i=0; i< dots.length; i++) {
      sum+=i;
      if (sum > rand) {
        return dots[i];
      }
    }


    return null;
  }

  void mutateNextGeneration() {
    for (int i=1; i<dots.length; i++)
      dots[i].brain.mutate();
  }
}
