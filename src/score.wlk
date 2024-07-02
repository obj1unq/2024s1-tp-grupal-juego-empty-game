import wollok.game.*
import mapa.*

class Score {

	var property position = null

	method image() {
		return "score.png"
	}

	method nacer() {
		game.addVisual(self)
	}

}

object score {
	 var property valor = 1000000	

	method scorear(puntos) {
		
		valor += puntos 
		
		
	}
	method image() {
		return "scoreFinal.png"
	}
	
	
	
	
	
	

}

class Digito {

	var property position = null

	method nacer() {
		game.addVisual(self)
	}

	method image()

}

class PrimerD inherits Digito { // unidad

	override method image() {
		return "0.png"
	}

}

class SegundoD inherits Digito {

	override method image() {
		 
		return score.valor().toString().charAt(5) + ".png"
	}

}

class TercerD inherits Digito { // centena

	override method image() {
		 
		return score.valor().toString().charAt(4) + ".png"
	}

}

class CuartoD inherits Digito {

	override method image() {
		
		return score.valor().toString().charAt(3) + ".png"
	}

}

