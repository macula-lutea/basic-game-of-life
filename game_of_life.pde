int cellSize = 8;
color alive = color(255, 0, 0);
color dead = color(0);


int[][] cells;
int[][] buffer;


void setup() {
  size (640, 640);
  background(0);

  cells = new int[width/cellSize][height/cellSize];

  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      cells[x][y] = int(random(2));
    }
  }
}


void draw() {

  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      if (cells[x][y]==1) {
        fill(alive);
      }
      else {
        fill(dead);
      }
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }

    // Store the current state in a buffer
    buffer = new int[width/cellSize][height/cellSize];
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        buffer[x][y] = cells[x][y];
    }
  }

    for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      int neighbors = 0;
      // Count the neighbors that are alive in the 4-neighborhood
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1;yy++) {
          if (((xx>=0)&&(xx<width/cellSize))&&((yy>=0)&&(yy<height/cellSize))) {
            if (!((xx==x)&&(yy==y))) { // Exclude self from the count
              if (buffer[xx][yy]==1){
                neighbors++;
              }
            }
          }
        }
      }

     // Update cells using the buffer and the neighbor count
      if (buffer[x][y]==1) {
        if (neighbors < 2 || neighbors > 3) {
          cells[x][y] = 0;
        }
      }
      else {
        if (neighbors == 3 ) {
          cells[x][y] = 1;
        }
      }
    }
  }

}
