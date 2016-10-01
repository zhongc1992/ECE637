#include <math.h>
#include "tiff.h"
#include "allocate.h"
#include "typeutil.h"
#include <stdio.h>
#include <stdlib.h>
#include "part2.h"




void median_weighted(struct loc pixel,unsigned char ** input, unsigned char ** output)
{
	/*int i, j, n=0, sum=0, sum_temp=0, temp;
	struct arow seq[25];
	
	for (i = -2; i < 3; i++)
	{
		for (j = -2; j < 3; j++)
		{
			if (i < 2 && j < 2)
			{
				seq[n].value = input[p.m + i + 2][p.n + j + 2];
				seq[n].weight = 2;
			}
			else
			{
				seq[n].value = input[p.m + i + 2][p.n + j + 2];
				seq[n].weight = 1;
			}
			n++;
		}
	}
	

	for (i = 0; i < 25; i++)
	{
		for (j = i + 1; j < 25; j++)
		{
			if (seq[j].value < seq[i].value)
			{
				temp = seq[i].value;
				seq[i].value = seq[j].value;
				seq[j].value = temp;

				temp = seq[i].weight;
				seq[i].weight = seq[j].weight;
				seq[j].weight = temp;
			}
		}
	}
	
	sum = 2 * 9 + 16;
	for (i = 0; i < 25; i++)
	{
		for (j = 0; j < i + 1; j++)
		{
			sum_temp = seq[j].weight + sum_temp;
		}
		if (sum_temp>sum - sum_temp)
			break;
	}

	output[p.m][p.n] = seq[j].value;*/
	struct arow sequence[25];
	int i,j,a=0,total = 0,add = 0;
	int n = 0;
	for (i = -2;i<3;i++)
	{
		for(j = -2;j<3;j++)
		{
			sequence[n].value = input[(pixel.m + 2)+i][(pixel.n+2)+j];
			if (i ==-2 || i==2 || j ==-2 || j==2)
			//if(i < 2 && j < 2)
			{
				sequence[n].weight = 1;
			}
			else
			{
				sequence[n].weight = 2;
			}
			n++;
		}
	}

    for (i = 0; i < 25; i++)
    {
        for (j = i + 1; j < 25; j++)
        {
            if (sequence[i].value < sequence[j].value)
            {
                a = sequence[i].value;
                sequence[i].value = sequence[j].value;
                sequence[j].value = a;
				
				a = sequence[i].weight;
				sequence[i].weight= sequence[j].weight;
                sequence[j].weight = a;
            }
        }
    }

	total = 18+16;
	for (i = 0; i < 25; i++)
    { 
        for (j = i + 1; j < 25; j++)
        {
            add=add + sequence[j].weight;
			
        }
		if (total - add >= add)
			{
				break;
			}
		else
		{
			add = 0;
		}
    }
	
	output[pixel.m][pixel.n] = sequence[i].value; 

}