## Put comments here that give an overall description of what your
## functions do
##
## :DP
## I followed the example provided for the vector case to cache
## the inverse of a matrix.
## Thanks to the forum:
## - https://class.coursera.org/rprog-004/forum/thread?thread_id=849#post-3849
## which pointed me here
## - https://class.coursera.org/rprog-004/forum/thread?thread_id=153#post-913)
## I realized (the obvious) that makeVector and makeCacheMatrix are lists of
## functions, which operate on the argument (vector/matrix).
##
## My makeCacheMatrix will contain the computation of the
## inverse matrix as well, which will be used by the cacheSolve function
##
## Write a short comment describing this function
## 
## The function takes a matrix as argument, the default being a NA 1x1 matrix.
## The function initializes the inverse xm1 to NULL, then defines the functions.

makeCacheMatrix <- function(x = matrix()) {
    xm1 <- NULL # Initalizing inverse matrix in the local scope

    # Initializes the matrix  and the inverse (overwriting the existing values)
    set <- function(y){
        x <<- y
        xm1 <<- NULL
    }

    # Retrieves the matrix
    get <- function() x

    # Actually setinv does not do what the name seems to suggest. It doesn not 
    # compute the inverse, but rather sets what ever is passed as argument to the
    # inverse of the matrix.
    setinv <- function( inv ) xm1 <<- inv

    # Actual computation of the inverse matrix calling solve
    compinv <- function() {
        xm1 <<- solve(x)
    # Uncomment the following line if you want xm1to be displayed
#        xm1
    }

    # Retrieves the inverse matrix
    getinv <- function() xm1

    # makeCacheMatrix returns a list of functions
    list( set=set,
          get=get,
          setinv=setinv,
          getinv=getinv,
          compinv=compinv )
}

## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    # Checks if the inverse has been already computed and associated to the
    # cache matrix. In this case xm1 is returned, otherwise (xm1 == NULL)
    # the inverse is computed. A message is printed in both cases.
    xm1 <- x$getinv()
    if(!is.null(xm1)){
        message("getting cached data")
        return(xm1)
    }

    message("computing...")
#    data <- x$get()
#    xm1 <- solve(data,...)
    # Rather than retrieving the data and calling solve, it calls the x$compinv()
    # function.
    xm1 <- x$compinv()
    # There's no need to call setinv, because compinv already returns the inverse.
#    x$setinv(xm1)

    # Comment the following line if you do not want to display the solution.
    xm1
}
