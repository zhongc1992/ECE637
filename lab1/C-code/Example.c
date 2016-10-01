
#include <math.h>
#include "tiff.h"
#include "allocate.h"
#include "randlib.h"
#include "typeutil.h"
#include <stdio.h>
#include <stdlib.h>
//#include <iostream>



struct pixel
{ 
	int m,n; /* m=row, n=col */
};
void ConnectedSet(struct pixel s, double T, unsigned char **img, int height, int width, int ClassLabel, unsigned int **seg, int *NumConPixels);
void ConnectedNeighbors(struct pixel s, double T, unsigned char **img, int height, int width, int *M, struct pixel *c);

void ConnectedNeighbors(
struct pixel s,
double T,
unsigned char **img,
int width,
int height,
int *M,
struct pixel *c);

void ConnectedSet(
struct pixel s,
double T,
unsigned char **img,
int width,
int height,
int ClassLabel,
unsigned int **seg,
int *NumConPixels);

void ConnectedNeighbors(
	struct pixel s,
	double T,
	unsigned char **img,
	int height,
	int width,
	int *M,
	struct pixel *c)
{
    //s.m only affect (x,y-1), (x,y+1) components.
	//s.n affects (x-1,y) and (x+1,y) components.

    int ind=0;
	//struct pixel cc;
	//cc.m = 3;
	//cc.n = 2;

    int x_comp[4] = {1,1,1,1}; // 1 means this component exists, 0 means to eliminate this component
    int y_comp[4] = {1,1,1,1}; //4 component follow clockwise direction, [0] is top, [1] is right,[2] is bottom, [3] is right
    int x_y[4];

    int x=0;
    int y=0;
    int count=0;

    if (s.m == 0) {y_comp[0] = 0;}

    else if (s.m == height-1) {y_comp[2] = 0;}

    if (s.n == 0) {x_comp[3] = 0;}

    if (s.n == width-1) {x_comp[1] = 0;}

    for (ind=0; ind<4; ind++) //check the 4 neighbors arround pixel s 
    { 
    	x_y[ind] = x_comp[ind]*y_comp[ind];
		if (x_y[ind] == 1){
			switch(ind){ 
				case 0:{
					x = s.n;
					y = s.m - 1;
					break;
					   }
				case 1:
				{
				x = s.n+1;
				y = s.m;
				break;
				}
				case 2:
				{
				x = s.n;
				y = s.m + 1;
				break;
				}
				case 3:
				{
				x = s.n-1;
				y = s.m;
				break;
				}
			}
		   if(abs(img[y][x]-img[s.m][s.n])<=T)
           {
	    	   c[count].m = y;
	           c[count].n = x;
	           count++;
           }
		}
    }
    *M = count;
}


void ConnectedSet(struct pixel s, double T, unsigned char **img, int height, int width, int ClassLabel, unsigned int **seg, int *NumConPixels)

{   
	//struct pixel *B;

	//B=(struct pixel*)malloc(height*width*sizeof(struct pixel));
 
	struct pixel b;

    int start = 0;
    int end = 0 ;
	//int m = s.m
     b.m = 3;

    struct pixel currpix;
    struct pixel c_c[4]; //input to connect_neighbor
	/*
    int k,M_M;//index and the input to connect_neighbor

    seg[s.m][s.n] = ClassLabel;

    while(start <= end)
    {   
        M_M=0;
        k=0;

        //pop first pixel in growing set as current pixel
	    currpix.m = B[start].m;
		currpix.n = B[start].n;
		start++;

        //search connected neighbor pixels
	    ConnectedNeighbors(currpix, T, img, height, width, &M_M, c_c);

	    //push unlabeled connected pixels in growing set
        for(k=0; k<M_M; k++)
        {  
        	   if(seg[c_c[k].m][c_c[k].n] == 0)
        	   {
        		   end++;
        	       B[end] = c_c[k];
        	       seg[B[end].m][B[end].n] = ClassLabel;
        	   }
        	   c_c[k].m = 0;
        	   c_c[k].n = 0;
        }

     }

     // if set size less than 100, clean the label of pixels in the set
     if (end<=100)
     {
        for (k=0; k<=end; k++)
        {
			seg[B[k].m][B[k].n] = 0;
		}
     }

     *NumConPixels = end;

	 //free(B);*/
}

int main (int argc, char **argv) 
{
    FILE *fp;
    struct TIFF_img input_img, output_img;
    struct pixel s;
    double T = 2;
    int width;
    int height;
    int ClassLabel=1;
    int i,j;
    unsigned int **seg;
    unsigned char **img;
	int NumConPixels=0;

	int M = 0;
	struct pixel c[4];

	

    /* open image file */
    if ( ( fp = fopen ( "E:\\2016spring\\ECE637\\lab3\\img22gd2.tif", "rb" ) ) == NULL ) {
        fprintf ( stderr, "cannot open file img22gd2.tif\n"  );
        exit ( 1 );
    }

    /* read image */
    if ( read_TIFF ( fp, &input_img ) ) {
        fprintf ( stderr, "error open file img22gd2.tif\n" );
        exit ( 1 );
    }

    /* close image file */
    fclose ( fp );

	img = (unsigned char**) get_img(input_img.height, input_img.width, sizeof(double));
	seg = (unsigned int**) get_img(input_img.height, input_img.width, sizeof(double));

    for(i=0; i<input_img.height; i++)
    for(j=0; j<input_img.width; j++)
    {
    	img[i][j] = input_img.mono[i][j];
		seg[i][j] = 0;
    }

     width = input_img.width;
    height = input_img.height;
	s.m =45;
	s.n = 67;
	//std::cout<<'s.m:'<<s.m<<std::endl;

	// ConnectedSet(s, T, img, height, width, ClassLabel, seg, &NumConPixels);
	 ConnectedNeighbors(s,T,img,height,width,&M,c);
	 printf("the result of M is : %d\n",M);
	 for (i = 0;i<4;i++)
	 {
	 printf("The member in c has %d,%d\n",c[i].m,c[i].n);
	 }
    /* deallocate space which was used for the images */
	free_img( (void**)img );
	free_img( (void**)seg );
    free_TIFF ( &(input_img) );
    free_TIFF ( &(output_img) );
  
    return(0);
}
