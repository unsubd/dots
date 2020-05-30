Population population;
Obstacle[] obstacles;
Goal goal;
void setup() {
  size(1000, 1000);
  population = new Population(1000);
  goal = new Goal(width/2, 20);
  obstacles = new Obstacle[3];
  obstacles[0]= new Obstacle(0, 500, 600, 20);
  obstacles[1]= new Obstacle(400, 700, 600, 20);
  obstacles[2]= new Obstacle(250, 200, 500, 20);
}

void draw() {
  background(255);
  goal.show();

  for (int i=0; i<obstacles.length; i++) {
    obstacles[i].show();
  }
  if (population.extinct()) {
    population.computeFitness();
    population.createNextGeneration();
    population.mutateNextGeneration();
  } else {
    population.move();
    population.show();
  }

  fill(100);
  textSize(24);
  text("Generation "+ population.gen, 20, 50);
  text("MinStep "+ (population.minStep > 1000 ? -1 : population.minStep), 20, 80);
  text("Best Dot " + population.bestDot.id, 20, 110);
  text("Best dot step " + population.bestDot.brain.step ,20,140);
}
