

import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> ();
int Bombs = 0;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    {
      for(int r = 0; r < NUM_ROWS; r++)
      {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r, c);
        }
      }
    }   
    setBombs();
}
public void setBombs()
{
  for(int i = 0; i < 50; i++)
  {
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    if(!bombs.contains(buttons[row][col]))
      bombs.add(buttons[row][col]);
      Bombs++;
  }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int win = 0;
    for(int i = 0; i < NUM_ROWS; i++)
      for(int j =0; j < NUM_COLS; j++)
        if(buttons[i][j].clicked)
          if(!bombs.contains(buttons[i][j]))
            win++;
    if(win==(NUM_ROWS*NUM_COLS-Bombs))
      return true;
    else
      return false;
}
public void displayLosingMessage()
{
    buttons[5][7].setLabel("YO");
    buttons[5][8].setLabel("U ");
    buttons[5][9].setLabel("HA");
    buttons[5][10].setLabel("VE");
    buttons[5][11].setLabel(" L");
    buttons[5][12].setLabel("OS");
    buttons[5][13].setLabel("T!");
    for(int i = 0; i < NUM_ROWS; i++)
      for(int j = 0; j < NUM_COLS; j++)
        buttons[i][j].clicked=true;
}
public void displayWinningMessage()
{
    buttons[5][7].setLabel("YO");
    buttons[5][8].setLabel("U ");
    buttons[5][9].setLabel("HA");
    buttons[5][10].setLabel("VE");
    buttons[5][11].setLabel(" W");
    buttons[5][12].setLabel("ON");
    buttons[5][13].setLabel("! ");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed== true) 
        {
          if(marked == false)
          {
            marked = true;
          }
          else if(marked == true)
          {
            marked = false;
            clicked = false;
          }
        }
        else if(bombs.contains(this))
          displayLosingMessage();
        else if(countBombs(r, c) > 0)
          label = str(countBombs(r, c));
        else
          for(int i = r-1; i <= r+1; i++)
          {
            for(int j = c-1; j <= c+1; j++)
            {
              if(isValid(i, j))
              {
                if(!buttons[i][j].clicked)
                buttons[i][j].mousePressed();
              }
            }
          }
         
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
      if(r>=0 && r<20 && c>=0 && c<20)
          return true;
        else
          return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(r, c+1) && bombs.contains(buttons[r][c+1]))
          numBombs++;
        if(isValid(r, c-1) && bombs.contains(buttons[r][c-1]))
          numBombs++;
        if(isValid(r+1, c) && bombs.contains(buttons[r+1][c]))
          numBombs++;
        if(isValid(r-1, c) && bombs.contains(buttons[r-1][c]))
          numBombs++;
        if(isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1]))
          numBombs++;
        if(isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1]))
          numBombs++;
        if(isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1]))
          numBombs++;
        if(isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1]))
          numBombs++;
          
        return numBombs;
    }
}