package main

import "fmt"

func main() {
	var a, b, c, d, e, f, g int
	fmt.Scan(&a)

	b = a / 100000
	c = (a / 10000) % 10
	d = (a / 1000) % 10
	e = (a / 100) % 10
	f = (a / 10) % 10
	g = a % 10
	a = b + c + d
	b = e + f + g
	if a == b {
		fmt.Println("YES")
	} else {
		fmt.Println("NO")
	}
}
