package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"
	"sync"
)

type Counter struct {
	mu    sync.RWMutex
	value int
}

func (c *Counter) Get() int {
	c.mu.RLock()
	defer c.mu.RUnlock()
	return c.value
}

func (c *Counter) Increment() int {
	c.mu.Lock()
	defer c.mu.Unlock()
	c.value++
	return c.value
}

func (c *Counter) Decrement() int {
	c.mu.Lock()
	defer c.mu.Unlock()
	c.value--
	return c.value
}

func (c *Counter) Reset() int {
	c.mu.Lock()
	defer c.mu.Unlock()
	c.value = 0
	return c.value
}

var counter = &Counter{}

const htmlTemplate = `
<!DOCTYPE html>
<html>
<head>
    <title>Counter App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        .container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            min-width: 300px;
        }
        .counter {
            font-size: 3rem;
            font-weight: bold;
            color: #333;
            margin: 1rem 0;
        }
        .buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }
        button {
            padding: 1rem 2rem;
            font-size: 1.2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .increment {
            background-color: #4CAF50;
            color: white;
        }
        .increment:hover {
            background-color: #45a049;
        }
        .decrement {
            background-color: #f44336;
            color: white;
        }
        .decrement:hover {
            background-color: #da190b;
        }
        .reset {
            background-color: #2196F3;
            color: white;
        }
        .reset:hover {
            background-color: #0b7dda;
        }
        h1 {
            color: #333;
            margin-bottom: 2rem;
        }
    </style>
    <script>
        function updateCounter(action) {
            fetch('/' + action, { method: 'POST' })
                .then(response => response.text())
                .then(value => {
                    document.getElementById('counter').textContent = value;
                })
                .catch(error => console.error('Error:', error));
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Counter Application</h1>
        <div class="counter" id="counter">{{.}}</div>
        <div class="buttons">
            <button class="decrement" onclick="updateCounter('decrement')">- Decrement</button>
            <button class="reset" onclick="updateCounter('reset')">Reset</button>
            <button class="increment" onclick="updateCounter('increment')">+ Increment</button>
        </div>
        <p style="margin-top: 2rem; color: #666; font-size: 0.9rem;">
            Cross-platform Golang GUI Counter<br>
            Built for AMD64 and ARM64 with musl compatibility
        </p>
    </div>
</body>
</html>
`

func homeHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.New("counter").Parse(htmlTemplate))
	tmpl.Execute(w, counter.Get())
}

func incrementHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}
	value := counter.Increment()
	fmt.Fprintf(w, "%d", value)
}

func decrementHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}
	value := counter.Decrement()
	fmt.Fprintf(w, "%d", value)
}

func resetHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}
	value := counter.Reset()
	fmt.Fprintf(w, "%d", value)
}

func main() {
	port := "8080"
	if len(os.Args) > 1 {
		port = os.Args[1]
	}

	http.HandleFunc("/", homeHandler)
	http.HandleFunc("/increment", incrementHandler)
	http.HandleFunc("/decrement", decrementHandler)
	http.HandleFunc("/reset", resetHandler)

	fmt.Printf("Counter application starting...\n")
	fmt.Printf("Open your browser and go to: http://localhost:%s\n", port)
	fmt.Printf("Press Ctrl+C to stop the server\n\n")
	
	log.Fatal(http.ListenAndServe(":"+port, nil))
}