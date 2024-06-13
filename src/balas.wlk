import wollok.game.*
import nave.* 
import posiciones.*
import aliens.*

class Bala {

	var property position = null
	const master = balasManager
//	const enemigo = flota
	

	method image() {
		return "bala.png"
	}
	
	method validarBala(){
		if (self.fueraDelTablero() and game.hasVisual(self)){
			master.quitar(self)
		}
	}
	
	method fueraDelTablero(){
		return position.y() >= game.height()  
	}

	method disparar(){
		if(game.hasVisual(self)){
			game.onTick(100, self.nombreTickDisparar(), {self.mover()})
		}
	}
	
	method collide(algo) {
		master.quitar(self)
		
		
	}
	
	method nombreTickDisparar() {
		return "DISPARO" + self.identity().toString()
	}
	
	method frenar() {
		game.removeTickEvent(self.nombreTickDisparar())
	}
	
	method mover() {
		position = position.up(1)
		self.validarBala()
	}
}

object balasManager {
	//balas
	const bala1 = new Bala()
	const bala2 = new Bala()
	const bala3 = new Bala()
	const bala4 = new Bala()
	const bala5 = new Bala()
	
	const property generadas = []
	const property noGeneradas = [bala1, bala2, bala3, bala4, bala5]
//	const carry = nave

	
	method generar() {
		if (noGeneradas.isEmpty()) {
		//	game.say(carry, "recargando")
		}
		else{
			game.addVisual(noGeneradas.first())	
			generadas.add(noGeneradas.first())
			
//			carry.validarDisparo(noGeneradas.first())
			noGeneradas.first().position(nave.position())
			noGeneradas.first().disparar()
			noGeneradas.remove(noGeneradas.first())
			}
		}
	
	method quitar(bala) {
		game.removeVisual(bala)
		generadas.remove(bala)
		noGeneradas.add(bala)
		bala.frenar()
		
	}
	
}
