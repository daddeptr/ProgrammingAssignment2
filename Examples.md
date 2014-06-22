### Caching the Inverse of a Matrix

Following the example of the vector mean, here is a function to cache
the inverse of a matrix. It uses the `<<-` operator, which can be used to
assign a value to an object in an environment that is different from the
current environment.

The function `makeCacheMatrix` creates a special "matrix", which is
really a *list* containing a function to

1.  set the value of the matrix (and its inverse)
2.  get the value of the matrix
3.  set the value of the inverse
4.  compute the value of the inverse
5.  get the value of the inverse

<!-- -->

	makeCacheMatrix <- function(x = matrix()) {
    	xm1 <- NULL

    	set <- function(y){
    	    x <<- y
        	xm1 <<- NULL
    	}

    	get <- function() x

	    setinv <- function( inv ) xm1 <<- inv

 		compinv <- function() {
    	    xm1 <<- solve(x)
    	# Uncomment the following line if you want xm1to be displayed
	#        xm1
    	}

	    getinv <- function() xm1

	    list( set=set,
   			get=get,
    		setinv=setinv,
        	getinv=getinv,
            compinv=compinv )
	}

The following function calculates the inverse of the special "matrix"
created with the above function. However, it first checks to see if the
inverse has already been calculated. If so, it `get`s the inverse from the
cache and skips the computation. Otherwise, it calculates the inverse of
the matrix and sets the value in the cache via the `compinv`
function.

	cacheSolve <- function(x, ...) {
	    xm1 <- x$getinv()
   	 	if(!is.null(xm1)){
        	message("getting cached data")
        	return(xm1)
    	}

    	message("computing...")
    	xm1 <- x$compinv()

    	# Comment the following line if you do not want to display the solution.
    	xm1
	}

### Example

Let's define a matrix

	> m <- matrix(1:4,2,2)
	> m
	     [,1] [,2]
	[1,]    1    3
	[2,]    2    4

And create the *special* cache-matrix

	> mc <- makeCacheMatrix(m)

We can retrieve the matrix m

	> mc$get()
    	 [,1] [,2]
	[1,]    1    3
	[2,]    2    4

that doesn't have any inverse matrix associated with it yet

	> mc$getinv()
	NULL

We can compute it and store it for later use

	> mc$compinv()
	> mc$getinv()
	     [,1] [,2]
	[1,]   -2  1.5
	[2,]    1 -0.5

(A simple check that we got it right)

	> mc$get() %*% mc$getinv()
    	 [,1] [,2]
	[1,]    1    0
	[2,]    0    1

Running `cacheSolve` on *mc* returns the inverse matrix w/o recomputing it.

	> cacheSolve(mc)
	getting cached data
    	 [,1] [,2]
	[1,]   -2  1.5
	[2,]    1 -0.5

However, if we reset the matrix using the `set` attribute, the inverse matrix is lost 

	> mc$set(m)
	> mc$getinv()
	NULL

and `cacheSolve` recomputes it.

	> cacheSolve(mc)
	computing...
    	 [,1] [,2]
	[1,]   -2  1.5
	[2,]    1 -0.5
	
	
	
	
	
	
	