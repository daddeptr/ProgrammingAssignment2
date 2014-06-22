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
mean has already been calculated. If so, it `get`s the mean from the
cache and skips the computation. Otherwise, it calculates the inverse of
the matrix and sets the value of the mean in the cache via the `compinv`
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

### Examples

	m <- matrix(1:4,2,2)
	mc <- makeCacheMatrix(mc)
	mc$get()
	mc$getinv()