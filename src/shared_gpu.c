#include <stdio.h>
#include <stdlib.h>

#include "csv.h"
#include "point.h"
#include "shared_gpu_k_clustering.h"

int main() {
	Point* points = readcsv();

	if (points == NULL) return 1;

	//Run k-means with 100 iterations and for 5 clusters
	k_means_clustering(points, LINE_COUNT - 1);
    
	writecsv(points);

	free(points);

	return 0;
}