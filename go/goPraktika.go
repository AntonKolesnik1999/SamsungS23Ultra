package main

import "fmt"

func main() {

        workArray := [10] int {0,0,0,0,0,0,0,0,0,0}
        var i, b, c, d, e, f, g, buf int

        for i = 0; i < 10; i++ {
                fmt.Scan(&workArray[i])
        }

	if b|c|d|e|f|g <10 {

	fmt.Scan(&b, &c, &d, &e, &f, &g)
	fmt.Println(workArray, b, c, d, e, f, g)

	buf = workArray[b]
	workArray[b]=workArray[c]
	workArray[c]=buf

        buf = workArray[d]
        workArray[d]=workArray[e]
        workArray[e]=buf

        buf = workArray[f]
        workArray[f]=workArray[g]
        workArray[g]=buf
	} else {
	}
	for i=0;i<10;i++{
		fmt.Print(workArray[i]," ")
}
}
