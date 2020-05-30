class Dot {

  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  String id;

  boolean alive = true;

  boolean reachedGoal = false;

  float fitness;
  boolean isBest = false;

  //int crossed = -1;
  //int stepAt = -1;
  
  Dot(int gen, int index) {
    this.id = String.format("%d:%d", gen, index);
    pos = new PVector(width/2, height - 100);
    vel = new PVector(0, 0);
    brain = new Brain(1000);
  }

  void show() {

    if (!isBest) {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    } else {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    }
  }

  void move() {

    if (brain.step < brain.directions.length) {
      acc = brain.directions[brain.step++];
    }

    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }

  void update() {

    if (alive && !reachedGoal) {
      move();
    }

    if (pos.x < 2 || pos.x > width -2 || pos.y < 2 || pos.y > height -2) {
      alive = false;
    } else if (dist(pos.x, pos.y, goal.pos.x, goal.pos.y) < 5) {
      reachedGoal = true;
    } else if (collided()) {
      alive = false;
    }
  }

  void computeFitness() {

    if (reachedGoal) {//if the dot reached the goal then the fitness is based on the amount of steps it took to get there
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } else {//if the dot didn't reach the goal then the fitness is based on how close it is to the goal
      float distanceToGoal = dist(pos.x, pos.y, goal.pos.x, goal.pos.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }

  Dot getChild(int gen, int index) {
    Dot child = new Dot(gen, index);
    child.brain = this.brain.clone();
    return child;
  }

  boolean collided() {
    boolean result = false;
    for (int i=0; i<obstacles.length; i++) {
      Obstacle obstacle = obstacles[i];
      if(pos.x > obstacle.pos.x && pos.x < (obstacle.pos.x + obstacle.length)){
        if(pos.y > obstacle.pos.y && pos.y < (obstacle.pos.y + obstacle.height)){
          result = true;
          break;
        }
      }
    }
    return result;
  }
}
