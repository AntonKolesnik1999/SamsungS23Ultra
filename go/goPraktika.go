package main

import "fmt"

func main(){
  
   var a int
fmt.Scan (&a)
   if  a<=0 {
      fmt.Println ("число R не подходит")
   } else if a>10000 {
      fmt.Printf ("%e", a)
   } else {
      a=a*a
      fmt.Println (a)
   }
   
}	
