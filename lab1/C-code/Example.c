
#include <math.h>
#include "tiff.h"
#include "allocate.h"
#include "randlib.h"
#include "typeutil.h"

void error(char *name);

int main (int argc, char **argv) 
{
  FILE *fp;
  struct TIFF_img input_img, color_img;
  double **img_red,**img_green,**img_blue,**img_0,**img_1,**img_2;


  int32_t i,j;
	
  if ( argc != 2 ) error( argv[0] );

  /* open image file */
  if ( ( fp = fopen ( argv[1], "rb" ) ) == NULL ) {
  //if ( ( fp = fopen ("E:\2016spring\ECE637\lab1_image_filter\Debug\img12.tif", "rb") ) == NULL ) {
    fprintf ( stderr, "cannot open file %s\n", argv[1] );
    exit ( 1 );
  }

  /* read image */
  if ( read_TIFF ( fp, &input_img ) ) {
    fprintf ( stderr, "error reading file %s\n", argv[1] );
    exit ( 1 );
  }

  /* close image file */
  fclose ( fp );

  /* check the type of image data */
  if ( input_img.TIFF_type != 'c' ) {
    fprintf ( stderr, "error:  image must be 24-bit color\n" );
    exit ( 1 );
  }

  /* Allocate image of double precision floats */
  img_red = (double **)get_img(input_img.width+1,input_img.height+1,sizeof(double));//imgsize + filtersize
  //img2 = (double **)get_img(input_img.width,input_img.height,sizeof(double));
  img_green = (double **)get_img(input_img.width+1,input_img.height+1,sizeof(double));
  img_blue = (double **)get_img(input_img.width+1,input_img.height+1,sizeof(double));


  img_0= (double **)get_img(input_img.width,input_img.height,sizeof(double));
  img_1 = (double **)get_img(input_img.width,input_img.height,sizeof(double));
  img_2 = (double **)get_img(input_img.width,input_img.height,sizeof(double));    
  /* set up structure for output color image */
  /* Note that the type is 'c' rather than 'g' */
  get_TIFF ( &color_img, input_img.height, input_img.width, 'c' );//the output img

  for (i = 0;i<input_img.height+1;i++){   //In the question, consider img_red,img_blue,img_green as y(m,n), an extra col added to the left, an extra row added to the top, with value 0.
    for(j = 0;j<input_img.width+1;j++){
      img_red[i][j] = 0;
      img_green[i][j] = 0;
      img_blue[i][j] = 0;  
    }
  }
  
  for (i = 0;i<input_img.height;i++){
    for(j = 0;j<input_img.width;j++){
      img_0[i][j] = input_img.color[0][i][j];
      img_1[i][j] = input_img.color[1][i][j];
      img_2[i][j] = input_img.color[2][i][j];
    }
  }
  
  
  /* Illustration: constructing a sample color image -- interchanging the red and green components from the input color image */
  for ( i = 0; i < input_img.height; i++ ){
      for ( j = 0; j < input_img.width; j++ ) {
      img_red[i+1][j+1] = 0.01*img_0[i][j] +0.9*(img_red[i][j+1]+img_red[i+1][j])-0.81*img_red[i][j];
	    img_green[i+1][j+1] = 0.01*img_1[i][j] +0.9*(img_green[i][j+1]+img_green[i+1][j])-0.81*img_green[i][j];
      img_blue[i+1][j+1] = 0.01*img_2[i][j] +0.9*(img_blue[i][j+1]+img_blue[i+1][j])-0.81*img_blue[i][j];

		  if ((int32_t)img_red[i+1][j+1]<0)
          {
            img_red[i+1][j+1]=0;
          }
          else if ((int32_t)img_red[i+1][j+1]>255)
          {
            img_red[i+1][j+1]=255;
          }
  
  if ((int32_t)img_green[i+1][j+1]<0)
          {
            img_green[i+1][j+1]=0;
          }
          else if ((int32_t)img_green[i+1][j+1]>255)
          {
            img_green[i+1][j+1]=255;
          }

  if ((int32_t)img_blue[i+1][j+1]<0)
          {
            img_blue[i+1][j+1]=0;
          }
          else if ((int32_t)img_blue[i+1][j+1]>255)
          {
            img_blue[i+1][j+1]=255;
          }

      }
}
  
 /*pixel value limitation*/
for ( i = 0; i < input_img.height; i++ ){
  for ( j = 0; j < input_img.width; j++ ) {
            color_img.color[0][i][j]=img_red[i+1][j+1]; //jump the first row an col,these are 0s, created for the calculation conviance.
          
            color_img.color[1][i][j]=img_green[i+1][j+1];
          
            color_img.color[2][i][j]=img_blue[i+1][j+1];
        
      } 
    }

    
  /* open color image file */
  if ( ( fp = fopen ( "result_Q5.tif", "wb" ) ) == NULL ) {
      fprintf ( stderr, "cannot open file color.tif\n");
      exit ( 1 );
  }
    
  /* write color image */
  if ( write_TIFF ( fp, &color_img ) ) {
      fprintf ( stderr, "error writing TIFF file %s\n", argv[2] );
      exit ( 1 );
  }
    
  /* close color image file */
  fclose ( fp );

  /* de-allocate space which was used for the images */
  free_TIFF ( &(input_img) );
  free_TIFF ( &(color_img) );
  free_img( (void**)img_red );
  free_img( (void**)img_blue );
  free_img( (void**)img_green );  
  free_img( (void**)img_0 );
  free_img( (void**)img_1 );
  free_img( (void**)img_2 );

  //system£¨"PAUSE"£©;
  return(0);
}

void error(char *name)
{
    printf("usage:  %s  image.tiff \n\n",name);
    printf("this program reads in a 24-bit color TIFF image.\n");
    printf("It then horizontally filters the green component, adds noise,\n");
    printf("and writes out the result as an 8-bit image\n");
    printf("with the name 'green.tiff'.\n");
    printf("It also generates an 8-bit color image,\n");
    printf("that swaps red and green components from the input image");
    exit(1);
}

