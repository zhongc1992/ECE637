
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
  double **img_red,**img_green,**img_blue;

  float lamda = 1.5;

  int32_t i,j,k,l;
  double r_value,g_value,b_value,r_temp,g_temp,b_temp;
	
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
  img_red = (double **)get_img(input_img.width+4,input_img.height+4,sizeof(double));//imgsize + filtersize
  //img2 = (double **)get_img(input_img.width,input_img.height,sizeof(double));
  img_green = (double **)get_img(input_img.width+4,input_img.height+4,sizeof(double));
  img_blue = (double **)get_img(input_img.width+4,input_img.height+4,sizeof(double));

    
  /* set up structure for output color image */
  /* Note that the type is 'c' rather than 'g' */
  get_TIFF ( &color_img, input_img.height, input_img.width, 'c' );//the output img

  for (i = 0;i<input_img.height+4;i++){
    for(j = 0;j<input_img.width+4;j++){
      img_red[i][j] = 0;
      img_green[i][j] = 0;
      img_blue[i][j] = 0;  
    }
  }
  
  for(i = 2;i<input_img.height+2;i++){
    for(j = 2;j<input_img.width+2;j++){
      img_red[i][j] = input_img.color[0][i-2][j-2];
      img_green[i][j] = input_img.color[1][i-2][j-2];
      img_blue[i][j] = input_img.color[2][i-2][j-2];     //create new imgs with boundary filled with 0
    }
  }

  /* Illustration: constructing a sample color image -- interchanging the red and green components from the input color image */
  for ( i = 0; i < input_img.height; i++ ){
      for ( j = 0; j < input_img.width; j++ ) {
	  r_value = 0;
	  g_value = 0;
	  b_value = 0;
	  for (k = -2; k <=2; k++ ){
     		 for ( l = -2; l <= 2; l++ ){
				r_value = r_value + (img_red[i+2-k][j+2-l])/25.0;   //i+4,j+4 are the index should start to read
				g_value = g_value + (img_green[i+2-k][j+2-l])/25.0;	
				b_value = b_value + (img_blue[i+2-k][j+2-l])/25.0;	
			  }	
			}	
      r_temp = ((lamda+1)*img_red[i+2][j+2] - lamda*r_value);
      g_temp = ((lamda+1)*img_green[i+2][j+2] - lamda*g_value);
      b_temp = ((lamda+1)*img_blue[i+2][j+2] - lamda*b_value);

      /*pixel limitation*/
      if (r_temp < 0){
        r_temp = 0;
      }
      else if (r_temp > 255){
        r_temp = 255;
      }
      if (g_temp < 0){
        g_temp = 0;
      }
      else if(g_temp > 255){
        g_temp = 255;
      }
      if(b_temp < 0){
        b_temp = 0;
      }
      else if(b_temp > 255){
        b_temp = 255;
      }

      color_img.color[0][i][j] = (int)(r_temp);
      color_img.color[1][i][j] = (int)(g_temp);
      color_img.color[2][i][j] = (int)(b_temp);

      }
}
  
  /* open color image file */
  if ( ( fp = fopen ( "Revised_result_Q4_lamda=1.5.tif", "wb" ) ) == NULL ) {
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

