package main

import (
	"fmt"
	"log"
	"net/http"
)

var dbPassword string = "Checkmarx!123"

func main() {
	fmt.Println("Starting server on http://localhost:8080")

	http.HandleFunc("/entry", func(w http.ResponseWriter, r *http.Request) {
		// Read ?param=value
		param := r.URL.Query().Get("param")
		pass := r.URL.Query().Get("pass")
		if param == "" && pass == dbPassword {
			param = "(no param provided)"
		}

		// Echo input safely
		response := fmt.Sprintf("You entered: %s", param)
		w.Write([]byte(response))
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
