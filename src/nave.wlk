import wollok.game.*
import posiciones.*
import nivel.*
import aliens.*
import balas.*

object nave {

	var property position = null
	const arma = balasManager

	method image() = "nave.png"

	method disparar(){
		arma.generar()
//		self.validarDisparo(bala)
//		bala.position(self.position())
//		bala.disparar()
		
	}
	
	method bloquear(){
		position = game.at(self.position().x(), 0)
	}
	
	
}

