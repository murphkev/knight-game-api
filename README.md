# Knight Game API

This API retrieves (one of) the shortest list(s) of moves for a knight to reach a target square. is currently hosted on Heroku:

https://glacial-savannah-02062.herokuapp.com/

Endpoints: 
* GET knight

Parameters:
* x = the current x position of the knight
* y = the current y position of the knight
* tx = the current x position of the target
* yx = the current y position of the target

Example usage:
The knight is at position (4, 5), and the target is position (6, 6)
* https://glacial-savannah-02062.herokuapp.com/knight?x=4&y=6&tx=6&ty=6
