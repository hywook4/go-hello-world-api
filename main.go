package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.GET("/hello-world", getHelloWorld)

	println("This is 프로덕션이지롱")
	router.Run("localhost:8080")
}

func getHelloWorld(c *gin.Context) {
	helloWorld := map[string]string{
		"message": "hello world!",
	}

	c.IndentedJSON(http.StatusOK, helloWorld)
}
